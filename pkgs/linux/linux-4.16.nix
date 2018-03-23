{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in
{
  nixpkgs.overlays = [( self: super: {
    linux_4_16_rc = unstable.linuxPackagesFor (unstable.callPackage <nixos-unstable/pkgs/os-specific/linux/kernel/linux-testing.nix> {
      kernelPatches = with unstable; [
        kernelPatches.bridge_stp_helper
        kernelPatches.modinst_arg_list_too_long
      ];
      argsOverride = with unstable; rec {
        version = "4.16-rc6";
        modDirVersion = "4.16.0-rc6";
        extraMeta.branch = "4.16";
        src = fetchurl {
          url = "https://git.kernel.org/torvalds/t/linux-${version}.tar.gz";
          sha256 = "0kwn1qj44pyb404qhwm4qr8mmfni8qfh1raf010d62i48n7pgv0d";
        };
      };
    });
  })];
}

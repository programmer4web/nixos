{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in
{
  nixpkgs.overlays = [( self: super: {
    linux_4_16 = unstable.linuxPackagesFor (unstable.callPackage <nixos-unstable/pkgs/os-specific/linux/kernel/linux-testing.nix> {
      kernelPatches = with unstable; [
        kernelPatches.bridge_stp_helper
        kernelPatches.modinst_arg_list_too_long
      ];
      argsOverride = with unstable; rec {
        version = "4.16";
        modDirVersion = "4.16.0";
        extraMeta.branch = "4.16";
        src = fetchurl {
          url = "https://git.kernel.org/torvalds/t/linux-${version}.tar.gz";
          sha256 = "0crdsyx42s5fw2gqzkh5ahj67pjw3fks5zannvixl65ycyziq74k";
        };
      };
    });
  })];
}

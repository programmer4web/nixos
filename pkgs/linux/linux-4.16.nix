{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [( self: super: {
    linux_4_16_r3 = (super.callPackage <nixos-unstable/pkgs/os-specific/linux/kernel/linux-testing.nix> {
      kernelPatches = with pkgs; [
        kernelPatches.bridge_stp_helper
        kernelPatches.modinst_arg_list_too_long
      ];
      argsOverride = with pkgs; rec {
        version = "4.16-rc3";
        modDirVersion = "4.16.0-rc3";
        extraMeta.branch = "4.16";

        src = fetchurl {
          url = "https://git.kernel.org/torvalds/t/linux-${version}.tar.gz";
          sha256 = "0y8h9bfyxyd1gwx6614ssnfqlckxps48s1ix2189yp6lwxxfhs4i";
        };
      };
    });
  })];
}

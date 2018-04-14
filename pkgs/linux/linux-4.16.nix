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
      argsOverride = with super.stdenv.lib; with unstable; rec {
        version = "4.16.2";
        modDirVersion = concatStrings (intersperse "." (take 3 (splitString "." "${version}.0")));
        extraMeta.branch = concatStrings (intersperse "." (take 2 (splitString "." version)));

        src = fetchurl {
          url = "mirror://kernel/linux/kernel/v4.x/linux-${version}.tar.xz";
          sha256 = "157q43px707nizqwzi5nk87c0nvdif9fbi751f71wpgfp3iiy2s7";
        };
      };
    });
  })];
}

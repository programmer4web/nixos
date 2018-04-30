{ config, lib, pkgs, ... }:
let
  kernelConfig = import ./config.nix;
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
    overlays = [(self: super: {
      linux_testing_slim = with kernelConfig; super.linux_testing.override({
        ignoreConfigErrors= true;
        extraConfig =''
          CPU_SUP_CENTAUR n
          MK8 n
          MPSC n
          MATOM n
          CC_OPTIMIZE_FOR_PERFORMANCE y
          ${exclude.uncommon}
          ${exclude.fs}
          ${exclude.net}
          ${exclude.wlan}
        '';
      });
    })];
  };
in
{
  nixpkgs.overlays = [( self: super: {
    linux_4_17           = unstable.linuxPackages_testing; 
    linux_4_17_slim      = unstable.linuxPackagesFor unstable.linux_testing_slim;
  })];
}

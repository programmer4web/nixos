{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [( self: super: {
    lm_sensors = with super; lm_sensors.overrideAttrs(old: rec {
      src = fetchFromGitHub {
        owner = "groeck";
        repo = "lm-sensors";
        rev = "6d970e5eb196061605c138c9dcbc833b052c4f3a";
        sha256 = "10rfrcr47a1j1dp55wbifygrnzp71xpig75qa5qam8mcrmfsp347";
      };
      patches = [];
    });
  })];
}

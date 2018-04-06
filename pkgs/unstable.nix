{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in {
  nixpkgs.overlays = [( self: super: {
    fish = unstable.fish;
  })];
}

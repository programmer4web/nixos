{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in {
  nixpkgs.overlays = [( self: super: {
    fish = unstable.fish;
  })];
}

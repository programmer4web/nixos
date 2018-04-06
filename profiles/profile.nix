{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };

in {
  imports = [
    ./local.nix
    ./plumelo.nix
    ../modules/services/X11/gnome3.nix 
  ];
}

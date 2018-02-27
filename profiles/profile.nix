{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};

in {
  imports = [
    ./local.nix
    ./plumelo.nix
    ../modules/services/X11/gnome3.nix 
  ];
}

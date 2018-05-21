{ config, lib, pkgs, ... }:
{
  imports = [
    ./local.nix
    ./plumelo.nix
    ../modules/services/X11/gnome3.nix 
    ../modules/hardware/video/bumblebee.nix
  ];
}

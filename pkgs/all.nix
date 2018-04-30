{ config, lib, pkgs, ... }:
{
  imports = [
    ./unstable.nix
    ./linux/it87.nix
    ./lm-sensors/lm-sensors.nix
  ];
}

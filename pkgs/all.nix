{ config, lib, pkgs, ... }:
{
  imports = [
    ./unstable.nix
    ./linux/linux-4.17.nix
    ./linux/it87.nix
    ./lm-sensors/lm-sensors.nix
  ];
}

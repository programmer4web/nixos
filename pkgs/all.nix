{ config, lib, pkgs, ... }:
{
  imports = [
    ./unstable.nix
    ./linux/linux-4.16.nix
    ./lm-sensors/lm-sensors.nix
  ];
}

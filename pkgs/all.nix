{ config, lib, pkgs, ... }:
{
  imports = [
    ./linux/linux-4.17.nix
    ./linux/it87.nix
    ./lm-sensors/lm-sensors.nix
  ];
}

{ config, lib, pkgs, ... }:
{
  hardware.bumblebee = {
    enable = true;
    connectDisplay = true;
  };

  services.xserver.displayManager.job.preStart = ''
    ${config.boot.kernelPackages.bbswitch}/bin/discrete_vga_poweron
  '';
}

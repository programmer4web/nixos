{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [( self: super: {
    virtualbox = with super; virtualbox.overrideAttrs (attrs: rec {
      name = "virtualbox-${version}";
      version = "5.2.10";
      src = fetchurl {
        url = "http://download.virtualbox.org/virtualbox/${version}/VirtualBox-${version}.tar.bz2";
        sha256 ="1k14ngz1gcz02qwbpzfp4kgxv8s24js8pwd5nyyqs6jpxx6557pd";
      };
      patches = attrs.patches ++ [ ./pci.4-17.patch];
    });
  })];
}

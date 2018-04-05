{ config, lib, pkgs, ... }: 
 
let 
  unstable = import <nixos-unstable> { 
    config.allowUnfree = true; 
  };
  kernel = config.boot.kernelPackages.kernel; 
in { 
  nixpkgs.overlays = [( self: super: { 
    it87  = unstable.stdenv.mkDerivation  rec { 
      name = "it87-${version}"; 
      version = "1.0"; 
      src = unstable.fetchFromGitHub { 
        owner = "groeck"; 
        repo = "it87"; 
        rev = "master"; 
        sha256 = "1kxhwpfv9324828bngviacyl05jlrkqryppr1h257nhypy9rpxyg"; 
      }; 
      hardeningDisable = ["pic"]; 
     nativeBuildInputs = kernel.moduleBuildDependencies; 
 
      preBuild = '' 
          substituteInPlace Makefile --replace "\$(shell uname -r)" "${kernel.modDirVersion}"
          substituteInPlace Makefile --replace "/lib/modules" "${kernel.dev}/lib/modules"
          substituteInPlace Makefile  --replace depmod \#  
          substituteInPlace Makefile --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/hwmon/" 
        ''; 
      preInstall = '' 
        mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/hwmon" 
      ''; 
    };
  })];
}

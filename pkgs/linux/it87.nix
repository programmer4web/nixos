{ config, lib, pkgs, ... }: 
 
let 
  kernel = config.boot.kernelPackages.kernel; 
in { 
  nixpkgs.overlays = [( self: super: { 
    it87  = with super; stdenv.mkDerivation  rec { 
      name = "it87-${version}"; 
      version = "1.0"; 
      src = fetchFromGitHub { 
        owner = "groeck"; 
        repo = "it87"; 
        rev = "3436b280785dbb05a73c5468d09d1e49e8ce09c9"; 
        sha256 = "1abp7jpacklhhmn1c265yyzgp8dph6cdjpgbwhvx8lf1xh6vzqdz"; 
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

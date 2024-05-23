{ config, pkgs, ...}: {
  powerManagement.enable = true;
  
  # fingerprints
  services.fprintd = {
    enable = true;
  };
  # firmware updates
  services.fwupd.enable = true;
  services.logind = {
    # extraConfig = "HandlePowerKey=suspend";
    lidSwitch = "hybrid-sleep";
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
}

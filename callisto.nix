{ config, pkgs, ...}: {
  networking.hostName = "callisto";
  powerManagement.enable = true;
  
  # fingerprints
  services.fprintd = {
    enable = true;
  };
  # firmware updates
  services.fwupd.enable = true;
  services.logind = {
    # extraConfig = "HandlePowerKey=suspend";
    lidSwitch = "hibernate";
    lidSwitchExternalPower = "ignore";
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  hardware.opentabletdriver.enable = true;
}

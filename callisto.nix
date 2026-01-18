{ config, pkgs, ... }:
{
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
    settings.Login = {
      HandleLidSwitch = "hibernate";
      HandleLidSwitchExternalPower = "ignore";
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
}

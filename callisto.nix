{ config, pkgs, ... }:
{
  networking.hostName = "callisto";
  powerManagement.enable = true;

  console.useXkbConfig = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };
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

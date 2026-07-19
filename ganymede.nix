{ config, pkgs, ... }:
{
  services.samba-wsdd.enable = true;
  services.ddclient = {
    enable = true;
    configFile = config.age.secrets.dyndns.path;
  };
  networking.hostName = "ganymede";
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        security = "user";
        workgroup = "HOMEGROUP";
        "server string" = "ganymede";
        "netbios name" = "ganymede";
        "hosts allow" = "192.168.50. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      public = {
        path = "/mnt/nvme1n1p1/samba/Shares/Public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "vael";
        "force group" = "users";
      };
      private = {
        path = "/mnt/nvme1n1p1/samba/Shares/Private";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "vael";
        "force group" = "users";
      };
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
  ];
  networking.firewall.allowedUDPPorts = [
  ];
  networking.firewall.extraCommands = "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";
}

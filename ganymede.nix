{ config, pkgs, ... }:
{
  services.samba-wsdd.enable = true;
  networking.hostName = "ganymede";
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        security = "user";
        workgroup = "HOMEGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
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
        "force group" = "vael";
      };
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
    6969 # bean chugger
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # wsdd
    6969 # bean chugger
  ];
  networking.firewall.extraCommands = "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";
}

{config, ...}: {
  services.samba-wsdd.enable = true;
  networking.hostName = "ganymede";
  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = HOMEGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.50. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
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
        # "force user" = "vael";
        # "force group" = "vael";
      };
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
    6969 # bean chugger
  ];
  networking.firewall.allowedUDPPorts = [
    3702 #wsdd
    6969 # bean chugger
  ];
};

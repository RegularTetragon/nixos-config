# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  home-manager,
  agenix,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    home-manager.nixosModules.default
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "v4l2loopback" "wacom" ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  boot.initrd.systemd.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  console.useXkbConfig = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.epson-escpr
    pkgs.epson-escpr2
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.syncthing = {
    enable = true;
    user = "vael";
    dataDir = "/home/vael/Sync";
    configDir = "/home/vael/.config/syncthing";
  };
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.nix-ld.enable = true;
  services.blueman.enable = true;
  # Enable sound with pipewire.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.steam-hardware.enable = true;
  hardware.xone.enable = true;
  # hardware.opentabletdriver.enable = true;
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.epkowa ];
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = true;
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
  security.tpm2.tctiEnvironment.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
#   extraConfig.pipewire = {
#    "10-clock-rate" = {
#      "context.properties" = {
#        "default.clock.rate" = 44100;
#      };
#    };
#  };

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # agenix secrets
  age.secrets = {
    nordvpn.file = secrets/nordvpn.age;
  };

  services.openvpn = {
    servers = {
      p2p = {
        config = ''
          config /root/nixos/openvpn/nord/tcp/us6660.nordvpn.com.tcp.ovpn
          auth-user-pass ${config.age.secrets.nordvpn.path}
        '';
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vael = {
    isNormalUser = true;
    description = "Vael Mattingly";
    shell = pkgs.nushell;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "terraria"
      "dialout"
      "tss"
      "scanner"
      "lp"
      "dialout"
      "input"
    ];
  };
  users.users.test = {
    isNormalUser = true;
    description = "Test Account";
    extraGroups = [

    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    tpm2-tss
    htop
    v4l-utils
    git
    docker-compose
    virt-manager
    zip
    unzip
    libsForQt5.qtstyleplugin-kvantum
    nix-index
    waypipe
    agenix.packages.x86_64-linux.default
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set number
        set autoindent
        set expandtab
        set tabstop=2
        set shiftwidth=2
      '';
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.uwsm = {
    enable = true;
    waylandCompositors = { };
  };
  programs.gamescope.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.waydroid.enable = true;
  programs.dconf.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  hardware.graphics.enable32Bit = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8000
  ];
  networking.firewall.allowedUDPPorts = [
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.allowPing = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

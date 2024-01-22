# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

 { config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
  # boot.supportedFilesystems = [ "bcachefs" ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;
   boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
   boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.forceImportRoot = false;
  # boot.zfs.extraPools = [ "Backup-zfs-2" ];
   networking.hostId = "3cc408bd";

  networking.hostName = "nix-nuc6"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  networking.interfaces.eth0.ipv4.addresses = [ {
  address = "192.168.1.30";
  prefixLength = 24;
} ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.desktopManager.cinnamon.enable = true;
  # services.cinnamon.apps.enable
  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents and enable scanners.
  # services.printing.enable = true;
  services.printing = {
    # run on first setup: sudo hp-setup -i -a
    enable  =  true;
    drivers = [ pkgs.hplipWithPlugin ];
};

  hardware.sane.enable = true; # enables support for SANE scanners
  services.ipp-usb.enable=true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  nixpkgs.config.packageOverrides = pkgs: {
    xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.fwupd.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.mince = {
    isNormalUser = true;
    description = "Mince";
    extraGroups = [ "networkmanager" "wheel" "mark" "mince" "monica" "scanner" "lp" ];
    packages = with pkgs; [
    # firefox
    ];
  };
users.users.mark = {
  isNormalUser  = true;
  uid = 1955;
  home  = "/home/mark";
  description  = "Mark";
  extraGroups  = [ "wheel" "networkmanager" "mark" "monica" "scanner" "lp" ];
  
};

users.users.monica = {
  isNormalUser  = true;
  uid = 1957;
  home  = "/home/monica";
  description  = "Monica";
  extraGroups  = [ "wheel" "networkmanager" "monica" "mark" "scanner" "lp" ];
  
};

  users.groups.mark.gid = 1955;
  users.groups.monica.gid = 1957;

  security.sudo.extraConfig = " Defaults	timestamp_timeout=60 ";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 # Fonts
  fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  corefonts
  google-fonts
  redhat-official-fonts
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      firefox
      kate
      conky
      thunderbird
      glabels
      golden-cheetah
      audacity
      strawberry
      gnome.simple-scan
      shotwell
      gnome.gnome-disk-utility
      vlc
      samba4Full
      audacious
      audacious-plugins
      asunder
      lxdvdrip
      libsForQt5.skanlite
      castnow
      libreoffice-qt
      neofetch
      cmatrix
      fswebcam
      home-manager
      sane-backends
      sane-frontends
      xsane
      hplipWithPlugin
      gutenprint
      gutenprintBin
      gimp-with-plugins
      usbutils
      webcamoid
      gedit
      home-manager
      killall
      lm_sensors
      htop
      gparted
      chromium
      pciutils
      fwupd
      easyeffects
      qpwgraph
      flac
      wavpack
      handbrake
      lame
      ffmpeg_5-full
      smplayer
      efibootmgr
      flatpak
      libsForQt5.bluez-qt
      bluez
      bluez-alsa
      bluez-tools
      openhantek6022
      mpv
      hplip
    ];

 # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # List services that you want to enable:
  # Auto system update
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.gvfs.enable = true;

  services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 2049 5357 ];
  # networking.firewall.allowedUDPPorts = [ 3702 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
# Automatic Garbage Collection
  nix.gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
        };
  boot.kernel.sysctl = { "vm.swappiness" = 10;};

 # NFS Server
 services.nfs.server.enable = true;
 services.nfs.server.exports = ''  /home 192.168.1.0/18(rw,async,insecure,no_root_squash,no_subtree_check)  '';

 # NFS Client
 # fileSystems."/nfs-mnt" = {
 #    device = "192.168.1.28:/home";
 #    fsType = "nfs";
 #    options = [ "x-systemd.automount" "noauto" ];
 #  };

 # Samba Server
services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
services.samba = {
  enable = true;
  securityType = "user";
  extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user 
    #use sendfile = yes
    #max protocol = smb2
    # note: localhost is the ipv6 localhost ::1
    hosts allow = 192.168.1. 127.0.0.1 localhost
    hosts deny = 0.0.0.0/0
    guest account = nobody
    map to guest = bad user
  '';
  shares = {
    public = {
      path = "/home";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
    private = {
      path = "/home/mark/Documents";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "username";
      "force group" = "groupname";
    };
  };
};
}

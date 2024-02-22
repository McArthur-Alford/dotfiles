{ config, pkgs, user, system, lib, ...}:
{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/desktop/hyprland 
    # ../../modules/programs/eww.nix
    ../../modules/programs/waybar.nix
    ../../modules/programs/wofi
    ../../modules/programs/docker.nix
    ../../modules/programs/godot.nix
    # (import ../../modules/programs/discord.nix {
    #   inherit pkgs;
    #   discordHash = "04r1yx6aqd4f4lq7wfcgs3jfpn40gz7gwajzai1aqz12ny78rs7z";
    # })
    ../../modules/services/gnome-keyring.nix
    ../../modules/kernels/latest.nix
    ../../modules/services/systemd-boot.nix
    # ../../modules/gpu/amd.nix
    ../../modules/programs/zsh.nix
    ../../modules/programs/swaylock.nix
  ];

  # Mount drives
  fileSystems."/mnt/storage" = {
    device = "/dev/nvme0n1p1";
    fsType = "ext4";
  };

   fileSystems."/mnt/fedora" = {
     device = "/dev/nvme2n1p3";
     fsType = "ext4";
   };

  # "i2c-piix4" for amd chipset?
  # boot.kernelModules = [ "i2c-dev" "i2c-i801" ];
  # services.udev.packages = [ pkgs.openrgb ];
  # hardware.i2c.enable = true;

  hardware.keyboard.qmk.enable = true;
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 25566 3000 ];
    allowedUDPPortRanges = [
      { from = 25565; to = 25566; }
    ];
    allowedUDPPorts = [ 3000 ];
  };
 
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  hardware.fancontrol.enable = true;
  hardware.fancontrol.config = ''
  Common Settings:
  INTERVAL=10

  Settings of hwmon8/pwm1:
    Depends on hwmon8/temp1_input
    Controls hwmon8/fan1_input
    MINTEMP=20
    MAXTEMP=50
    MINSTART=150
    MINSTOP=0
    MAXPWM=255
  '';
  programs.corectrl.enable = true;

  services.dnsmasq.enable = true;

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      carlito
      dejavu_fonts
      ipafont
      kochi-substitute
      source-code-pro
      ttf_bitstream_vera
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
        "IPAGothic"
      ];
      sansSerif = [
        "DejaVu Sans"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };
  };  


  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "mcarthur" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment = {
    systemPackages = with pkgs; [					# Packages not offered by Home-Manager
      # Dungeondraft/Wonderdraft
      # (callPackage ../../modules/editors/wonderdraft/wonderdraft.nix {})
      # (callPackage ../../modules/editors/dungeondraft/dungeondraft.nix {})
      # (callPackage ../../weird.nix {})
      pipewire


      # Cisco any connect for uq network vpn
      openconnect_openssl

      
      # openrgb-with-all-plugins.out
      # # openrgb
      # i2c-tools

      anki-bin

      usbutils

      xorg.libXxf86vm

      # Screen recording!
      # gpu-screen-recorder
      # gpu-screen-recorder-gtk

      freshfetch
      # steam
      lutris
      gnome.nautilus
      nautilus-open-any-terminal
      libsForQt5.qt5ct
      gamescope

      dnsmasq

      # wine
      wineWowPackages.stable
      winetricks

      # headset
      (headsetcontrol.overrideAttrs (finalAttrs: previousAttrs: {
        src = fetchFromGitHub {
          owner = "Sapd";
          repo = "HeadsetControl";
          rev = "464a12a5679d431b148aea53bceba88b9414ad1f";
          sha256 = "sha256-tAndkfLEgj81JWzXtDBNspRxzKAL6XaRw0aDI1XbC1E=";
        };
      }))

      # webcord
      discord

      pandoc

      # polkit
      polkit

      # Blender
      blender
      qsynth

      # only useful for AMD gpu
      radeontop

      # Jetbrains
      jetbrains.idea-community

      # Minecraft
      prismlauncher

      mousai

      element-desktop
    ];

    etc."spotify".source = "${pkgs.spotify}"; # Spotify fixed path for spicetify to use
  };

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12e0", TAG+="uaccess"
  '';

   nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };

  programs = {
    virt-manager.enable = true;

    # gamescope = {
    #   enable = true;
    #   capSysNice = true;
    # };

    steam = {
      enable = true;
    };
  
    # steam = {
    #   enable = true;
    #   package = pkgs.steam.override {
    #     extraPkgs = pkgs: with pkgs; [
    #       gamescope
    #       mangohud
    #       xorg.libXcursor
    #       xorg.libXi
    #       xorg.libXinerama
    #       xorg.libXScrnSaver
    #       libpng
    #       libpulseaudio
    #       libvorbis
    #       stdenv.cc.cc.lib
    #       libkrb5
    #       keyutils
    #     ];
    #   };
    #   gamescopeSession = {
    #     enable = true;
    #   };
    # };
    gamemode.enable = true;						# Better performance
    									                # Steam: Launch Options: gamemoderun %command%
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" "audio" "corectrl" ];
  };

  # Disable autosleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

{ pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware.nix
    (../../nixos/common/hardware/systemd-boot.nix)
    (../../nixos/common/services/audio.nix)

    # TODO remove these eventually, move them into nixos
    ../../../modules/programs/waybar.nix
  ];

  networking = {
    hostName = "thaumaturge";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 25565 25566 3000 ];
      allowedUDPPortRanges = [
        { from = 25565; to = 25566; }
      ];
      allowedUDPPorts = [ 3000 ];
    };
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

  environment = {
    systemPackages = with pkgs; [ # Packages not offered by Home-Manager
      anki-bin
      usbutils
      xorg.libXxf86vm
      neofetch
      lutris    
      gnome.nautilus
      nautilus-open-any-terminal
      libsForQt5.qt5ct
      gamescope
      dnsmasq
      wineWowPackages.stable
      winetricks
      (headsetcontrol.overrideAttrs (finalAttrs: previousAttrs: {
        src = fetchFromGitHub {
          owner = "Sapd";
          repo = "HeadsetControl";
          rev = "464a12a5679d431b148aea53bceba88b9414ad1f";
          sha256 = "sha256-tAndkfLEgj81JWzXtDBNspRxzKAL6XaRw0aDI1XbC1E=";
        };
      }))
      discord
      polkit
      blender
      qsynth
      radeontop
      jetbrains.idea-community
      element-desktop
    ];

    etc."spotify".source = "${pkgs.spotify}";
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
    steam = {
      enable = true;
    };
    gamemode.enable = true;
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}

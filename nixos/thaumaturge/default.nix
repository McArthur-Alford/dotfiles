{ pkgs, nixpkgs, ... }:
{
  imports = [
    ./hardware.nix
    ../../nixos/common/hardware/systemd-boot.nix
    ../../nixos/common/services/audio.nix
    ../../nixos/common/services/gnome-keyring.nix
    ../../nixos/common/services/bluetooth.nix
    ../../nixos/common/programs/steam.nix
    ../../nixos/common/programs/vencord.nix
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

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12e0", TAG+="uaccess"
  '';

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}

{ pkgs, config, ... }:
{
  imports = [
    ./hardware.nix
    ../../nixos/common/hardware/systemd-boot.nix
    ../../nixos/common/services/audio.nix
    ../../nixos/common/services/gnome-keyring.nix
    ../../nixos/common/services/bluetooth.nix
    # ../../nixos/common/programs/steam.nix
    ../../nixos/common/programs/vencord.nix
    ../../nixos/common/services/virtualisation.nix
    ../../nixos/common/services/avahi.nix
  ];

  networking = {
    hostName = "mosaic";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 ];
      allowedUDPPortRanges = [ ];
      allowedUDPPorts = [ 3000 ];
    };
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;

  # hardware.fancontrol.enable = true;
  # hardware.fancontrol.config = ''
  #   Common Settings:
  #   INTERVAL=10

  #   Settings of hwmon8/pwm1:
  #     Depends on hwmon8/temp1_input
  #     Controls hwmon8/fan1_input
  #     MINTEMP=20
  #     MAXTEMP=50
  #     MINSTART=150
  #     MINSTOP=0
  #     MAXPWM=255
  # '';
  # programs.corectrl.enable = true;

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

  systemd.targets = {
    sleep.enable = true;
    suspend.enable = true;
    hibernate.enable = true;
    hybrid-sleep.enable = true;
  };
}

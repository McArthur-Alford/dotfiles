{ pkgs, config, lib, ... }:
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

  boot.binfmt.emulatedSystems = [ "aarch64-linux" "armv6l-linux" "armv7l-linux" ];

  # environment.systemPackages = with pkgs; [
  #   hostapd dnsmasq
  # ];

  networking = {
    hostName = "mosaic";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 ];
      allowedUDPPortRanges = [ ];
      allowedUDPPorts = [ 3000 53 67 ];
    };
    # wlanInterfaces = {
    #   "wlan-station0" = { device = "wlp1s0"; };
    #   "wlan-ap0" = { 
    #     device = "wlp1s0"; 
    #     mac = "08:11:96:0E:08:0A";
    #   };
    # };

    # networkmanager.unmanaged = [ "interface-name:wlp*" ] ++ lib.optional config.services.hostapd.enable "interface-name:${config.services.hostapd.interface}";

    # interfaces."wlan-ap0".ipv4.addresses = 
    #   lib.optionals config.services.hostapd.enable [{ address = "192.168.12.1"; prefixLength = 24;}];


  };

  # services.hostapd = {
  #   radios.wlan-ap0 = {
  #     networks.wlan-ap0 = {
  #       enable = true;
  #       hwMode = "g";
  #       interface = "wlan0";
  #       ssid = "mosaic_hotspot";
  #       # authentication.wpaPassword = "magical1234";
  #     };
  #   };
  # };

  # services.dnsmasq = lib.optionalAttrs config.services.hostapd.enable {
  #   enable = true;
  #   extraConfig = ''
  #     interface=wlan-ap0
  #     bind-interfaces
  #     dhcp-ranges=192.168.12.10,192.168.12.254,24h
  #   '';
  # };

  # services.haveged.enable = config.services.hostapd.enable;

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

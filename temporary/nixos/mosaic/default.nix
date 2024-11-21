{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../nixos/common/programs/steam.nix
    ../../nixos/common/services/peerix.nix
    ../../nixos/common/hardware/systemd-boot.nix
    ../../nixos/common/services/audio.nix
    ../../nixos/common/services/gnome-keyring.nix
    ../../nixos/common/services/bluetooth.nix
    ../../nixos/common/programs/vencord.nix
    ../../nixos/common/services/virtualisation.nix
    ../../nixos/common/services/avahi.nix
  ];

  # Enable Perf
  # boot.kernel.sysctl."kernel.perf_event_paranoid" = -1;
  # boot.kernel.sysctl."kernel.kptr_restrict" = lib.mkForce 0;
  # systemd.tmpfiles.rules = [ "L /lib - - - - /run/current/system/lib" ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "armv6l-linux"
    "armv7l-linux"
  ];

  time.timeZone = "Australia/Brisbane";

  networking = {
    hostName = "mosaic";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        3000
        4242
      ];
      allowedUDPPortRanges = [ ];
      allowedUDPPorts = [
        3000
        53
        67
        4242
      ];
    };
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.power-profiles-daemon.enable = true;
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

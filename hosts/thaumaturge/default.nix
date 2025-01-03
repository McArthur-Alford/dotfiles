{
  pkgs,
  self,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    "${self}/modules/bootloader/systemd.nix"
    "${self}/modules/hardware/amd.nix"
    "${self}/modules/services/pipewire.nix"
    "${self}/modules/services/peerix.nix"
    "${self}/modules/services/gnome-keyring.nix"
    "${self}/modules/services/bluetooth.nix"
    "${self}/modules/services/virtualisation.nix"
    "${self}/modules/services/avahi.nix"
    "${self}/modules/services/ratbag.nix"
    "${self}/modules/services/cachix.nix"
    "${self}/modules/programs/steam.nix"
    "${self}/modules/programs/caching.nix"
    "${self}/modules/kernel/patches/odysseyg9.nix"
    "${self}/modules/services/printing.nix"
    "${self}/modules/hardware/pentablet.nix"
  ];

  # Enable binfmt emulation of aarch64-linux.
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "armv6l-linux"
  ];

  time.timeZone = lib.mkForce "Australia/brisbane";
  services.automatic-timezoned.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        25565
        25566
        25049
        3000
        5432
        4242
      ];
      allowedUDPPortRanges = [
        {
          from = 25565;
          to = 25566;
        }
      ];
      allowedUDPPorts = [
        3000
        25049
        4242
      ];
    };
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.corectrl.enable = true;
  programs.coolercontrol.enable = true;

  programs.steam.extest.enable = true;

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

  boot.tmp.cleanOnBoot = true;

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038", ATTRS{idProduct}=="12e0", TAG+="uaccess"
    SUBSYSTEM=="usb", MODE="0660", GROUP="usb"
  '';

  systemd.targets = {
    sleep.enable = true;
    suspend.enable = true;
    hibernate.enable = true;
    hybrid-sleep.enable = true;
  };
}

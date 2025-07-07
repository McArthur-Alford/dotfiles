{
  pkgs,
  self,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./hardware.nix
    "${self}/modules/services/pipewire.nix"
    "${self}/modules/services/peerix.nix"
    "${self}/modules/services/gnome-keyring.nix"
    "${self}/modules/services/bluetooth.nix"
    "${self}/modules/services/virtualisation.nix"
    "${self}/modules/services/avahi.nix"
    "${self}/modules/services/cachix.nix"
    "${self}/modules/programs/caching.nix"
    "${self}/modules/services/openconnect-sso.nix"
    "${self}/modules/services/docker.nix"
    "${self}/modules/foundry/fvtt_mod.nix"
    "${self}/modules/services/peerix.nix"

    # inputs.determinate.nixosModules.default
  ];

  hardware.graphics.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [ nginx ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/md126"; # or "nodev" for efi only

  # Enable binfmt emulation of aarch64-linux.
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    "armv6l-linux"
  ];

  boot.kernelPackages = pkgs.linuxPackages_6_15;

  time.timeZone = lib.mkForce "Australia/brisbane";
  services.automatic-timezoned.enable = true;

  networking = {
    hostName = "benefactor";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        22
        25565
        3000
        3001
        8080
        8000
        9000
        27016
        27015
        27031
        27036
      ];
      allowedTCPPortRanges = [
        {
          from = 27031;
          to = 27036;
        }
        {
          from = 29999;
          to = 30003;
        }
      ];
      allowedUDPPorts = [
        27015
        27016
        25565
        27031
        27036
      ];
      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4007;
        }
        {
          from = 8000;
          to = 8010;
        }
        {
          from = 9876;
          to = 9877;
        }
      ];
    };
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.corectrl.enable = true;
  programs.coolercontrol.enable = true;

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
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
  powerManagement.enable = false;

  # Server hosting stuff below this point:
  sops.secrets.tunnel-credentials = {
    owner = "cloudflared";
    group = "cloudflared";
    name = "tunnel-credentials.json";
    format = "binary";
    sopsFile = "${self}/secrets/tunnel-credentials";
    restartUnits = [ "cloudflared-tunnel-e8e9f688-e79d-44d6-a871-02656fc3dd8e.service" ];
  };

  services.cloudflared = {
    enable = true;
    # user = "cloudflared";
    # group = "cloudflared";
    tunnels = {
      "e8e9f688-e79d-44d6-a871-02656fc3dd8e" = {
        credentialsFile = "${config.sops.secrets.tunnel-credentials.path}";
        default = "http_status:404";
        # warp-routing.enabled = true;
        ingress = {
          "benefactor.thaumaturgy.tech".service = "ssh://localhost:22";
          "mosaic.thaumaturgy.tech".service = "ssh://mosaic.local:22";
          "thaumaturge.thaumaturgy.tech".service = "ssh://thaumaturge.local:22";
          "cache.thaumaturgy.tech".service = "http://localhost:5000";
          # "overlord.thaumaturgy.tech".service = "http://192.168.100.2:30000";
          "overlord.thaumaturgy.tech".service = "http://192.168.100.4:30000";
          "foundry.thaumaturgy.tech".service = "http://192.168.100.5:30000";
          "battletech.thaumaturgy.tech".service = "http://192.168.100.6:30000";
          "foundry11.thaumaturgy.tech".service = "http://192.168.100.7:30000";
          "foundry13.thaumaturgy.tech".service = "http://192.168.100.8:30000";
          "minecraft.thaumaturgy.tech".service = "http://localhost:25565";
        };
      };
    };
  };

  users.users.cloudflared.group = "cloudflared";
  users.users.cloudflared.isSystemUser = true;
  users.groups.cloudflared = { };

  systemd.services.cloudflared-tunnel-e8e9f688-e79d-44d6-a871-02656fc3dd8e.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "cloudflared";
    Group = "cloudflared";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "mcarthur.alford@pm.me";
  };

  fvtt.enable = true;
  fvtt.interface = "eno1";
  fvtt.instances = {
    "overlord" = {
      ident = "overlord";
      ip = "192.168.100.4";
      version = "12.331";
      dir = "/mnt/sdd/fvtt";
    };
    "apples" = {
      ident = "apples";
      ip = "192.168.100.5";
      version = "12.331";
      dir = "/mnt/sdd/fvtt";
    };
    "apples11" = {
      ident = "apples11";
      ip = "192.168.100.7";
      version = "11.315";
      dir = "/mnt/sdd/fvtt";
    };
    "battletech" = {
      ident = "battletech";
      ip = "192.168.100.6";
      version = "10.312";
      dir = "/mnt/sdd/fvtt";
    };
    "foundry13" = {
      ident = "foundry13";
      ip = "192.168.100.8";
      version = "13.341";
      dir = "/mnt/sdd/fvtt";
    };
  };

}

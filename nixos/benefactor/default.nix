{
  pkgs,
  username,
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    # ../../nixos/common/hardware/systemd-boot.nix
    ../../nixos/common/services/gnome-keyring.nix
    ../../nixos/common/services/bluetooth.nix
    ../../nixos/common/services/virtualisation.nix
    ../../nixos/common/services/avahi.nix
    inputs.attic.nixosModules.atticd
  ];

  environment.systemPackages = with pkgs; [
    nginx
    attic-client
    attic-server
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Use the GRUB 2 boot loader.
  # TODO refactor this into a module
  boot.loader.grub.enable = true;
  # boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/md126"; # or "nodev" for efi only

  networking = {
    hostName = "benefactor";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        22
        3000
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
      ];
      allowedUDPPorts = [
        27015
        27016
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

  # nginx TODO factor this out into a module
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts = {
      "thaumaturgy.tech" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://localhost:30000";
      };
      "apples.thaumaturgy.tech" = {
        locations."/".proxyPass = "http://127.0.0.1:30001";
        locations."/".proxyWebsockets = true;
        forceSSL = true;
        enableACME = true;
      };
      "overlord.thaumaturgy.tech" = {
        locations."/".proxyPass = "http://127.0.0.1:30000";
        locations."/".proxyWebsockets = true;
        forceSSL = true;
        enableACME = true;
      };
      # "cloud.thaumaturgy.tech" = {
      #   forceSSL = true;
      #   enableACME = true;
      # };
    };
  };

  sops.secrets.tunnel-credentials = {
    owner = "cloudflared";
    group = "cloudflared";
    name = "tunnel-credentials.json";
    format = "binary";
    sopsFile = ../../secrets/tunnel-credentials;
  };

  services.cloudflared = {
    enable = true;
    user = "cloudflared";
    group = "cloudflared";
    tunnels = {
      "e8e9f688-e79d-44d6-a871-02656fc3dd8e" = {
        credentialsFile = config.sops.secrets.tunnel-credentials.path;
        default = "http_status:404";
        # warp-routing.enabled = true;
        ingress = {
          "benefactor.thaumaturgy.tech".service = "ssh://localhost:22";
          "mosaic.thaumaturgy.tech".service = "ssh://mosaic.local:22";
          "thaumaturge.thaumaturgy.tech".service = "ssh://thaumaturge.local:22";
          "attic.thaumaturgy.tech".service = "http://localhost:8080";
        };
      };
    };
  };

  sops.secrets.attic-server-token = {
    name = "attic-server-token";
    format = "binary";
    sopsFile = ../../secrets/attic-server-token;
  };

  systemd.services.atticd = {
    serviceConfig.ReadWritePaths = "/mnt/sdb/attic/storage";
  };

  services.atticd = {
    enable = true;

    credentialsFile = config.sops.secrets.attic-server-token.path;

    mode = "monolithic";

    settings = {
      listen = "[::]:8080";

      chunking = {
        nar-size-threshold = 64 * 1024; # 64 KiB
        min-size = 16 * 1024; # 16 KiB
        avg-size = 64 * 1024; # 64 KiB
        max-size = 256 * 1024; # 256 KiB
      };

      storage = {
        type = "local";
        path = "/mnt/sdb/attic/storage";
      };

      garbage-collection = {
        interval = "1 days";
        default-retention-period = "3 months";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "mcarthur.alford@pm.me";
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

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
  powerManagement.enable = false;
}

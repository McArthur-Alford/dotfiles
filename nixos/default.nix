{ config, desktop, hostname, inputs, lib, modulesPath, outputs, pkgs, system, stateVersion, username, nixpkgs, ...}: {
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
    ./${hostname}
    ./common/base
    ./common/scripts
    ./common/services/firewall.nix
    ./common/services/openssh.nix
    ./common/users/root
  ]
  ++ lib.optional (builtins.pathExists (./. + "/common/users/${username}")) ./common/users/${username}
  ++ lib.optional (desktop != null) ./common/desktop;

  nixpkgs.hostPlatform = lib.mkDefault system;

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  documentation = {
    enable = true;
    nixos.enable = true;
    man.enable = true;
    info.enable = true;
    doc.enable = true;
  };

  fonts.packages = with pkgs; [
    source-code-pro
    font-awesome
    corefonts
    material-design-icons
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {
    systemPackages = with pkgs; [
      git
      helix
      nil
      wget
      curl
    ];
    variables = {
      SYSTEMD_EDITOR = "hx";
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };

  networking = {
    networkmanager = {
      enable = true;
    };
  };

  programs = {
    command-not-found.enable = false;
  };

  environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;

  nixpkgs = {
    overlays = [
      # outputs.overlays.<overlay>
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    package = pkgs.nixFlakes;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      sandbox = true;
    };
  };

  system.stateVersion = stateVersion;
}

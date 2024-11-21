{
  lib,
  system,
  stateVersion,
  pkgs,
  nixpkgs,
  outputs,
  ...
}:
{
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
    jetbrains-mono
    nerdfonts
    comic-mono
  ];

  environment = {
    systemPackages = with pkgs; [
      git
      # inputs.helix.packages.${system}.default
      helix
      helix-gpt
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

  environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;

  nixpkgs = {
    hostPlatform = lib.mkDefault system;
    overlays =
      [
      ];
    config = {
      allowUnfree = true;
    };
  };

  boot.tmp.cleanOnBoot = true;

  # We cant use command-not-found because nix-index is installed!
  programs.command-not-found.enable = false;

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    package = pkgs.nixVersions.stable;

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      sandbox = true;
    };

    registry.devtemplates = {
      to = {
        owner = "McArthur-Alford";
        repo = "nix-templates";
        type = "github";
      };
      from = {
        id = "devtemplates";
        type = "indirect";
      };
    };
  };

  system.stateVersion = stateVersion;
}

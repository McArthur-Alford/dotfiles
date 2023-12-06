# Global Configuration For All Devices
{ lib, config, pkgs, user, nixpkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Flatpak
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  services.flatpak.enable = true;

  # nixpkgs stuff
  environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
  nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];

  # Dconf
  programs.dconf.enable = true;

  # Fonts
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

  # Security
  security = {
    sudo.wheelNeedsPassword = false;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "hx";
      VISUAL = "hx";
    };
    systemPackages = with pkgs; [
      nil # Nix language server, HANDY TO HAVE ON NIXOS
      # nixd # not as good as nil :)
      vim
      wget
      alacritty
      git 
      killall
      libgcc
      wireplumber
      pipewire
    ];
  };

  systemd.services.nix-daemon.serviceConfig = {
    CPUQuota = ["90%"];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      sandbox = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
      X11Forwarding = true;
    };
  };
  users.users.${user}.openssh.authorizedKeys.keyFiles = [
    ../sshKeys/desktop.pub
    ../sshKeys/laptop.pub
    ../sshKeys/server.pub
  ];

  # Pulseaudio setup
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseaudio = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;
}

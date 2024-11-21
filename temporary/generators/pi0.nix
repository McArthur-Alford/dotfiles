{ nixpkgs, pkgs, lib, ... }:
let
  user = "pi0";
  password = "pi0";
  hostname = "pi0";
  overlays = [
    (_final: super: { })
  ];
in
{
  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
  ];

  time.timeZone = "Australia/brisbane";
  i18n.defaultLocale = "it_IT.UTF-8";
  sdImage.compressImage = false;
  console.keyMap = "it";
  
  nixpkgs.overlays = overlays;

  boot.loader.grub.efiSupport = lib.mkForce false;
  isoImage.makeEfiBootable = lib.mkForce false;

  # SSH Config
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "yes";
      X11Forwarding = true;
    };
  };
  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Automatic Wifi
  networking = {
    wireless = {
      enable = true;
      networks = {
        ammwbase = {
          psk = "Z57TH2JCYW";
        };
      };
    };
    useDHCP = true;
    hostName = hostname;
  };

  # Basic user, not very secure though
  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      inherit password;
      extraGroups = [ "wheel" ];
    };
    users.root = {
      inherit password;
    };
  };


  hardware.enableRedistributableFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}

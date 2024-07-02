{ nixpkgs, pkgs, ... }:
let
  user = "pi4";
  password = "pi4";
  hostname = "pi4";
  overlays = [
    (_final: super: { })
  ];
in
{
  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
  ];

  time.timeZone = "Australia/brisbane";
  i18n.defaultLocale = "it_IT.UTF-8";
  sdImage.compressImage = false;
  console.keyMap = "it";
  
  nixpkgs.overlays = overlays;

  # Automatic WIFI connection
  networking = {
    wireless = {
      enable = true;
      networks = {
        TelstraDC701F = {
          psk = "ha4c6rh7s44qcrtt";
        };
      };
    };
    useDHCP = true;
    hostName = hostname;
  };

  # environment.systemPackages = with pkgs; [ helix ];

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

  # Basic user
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

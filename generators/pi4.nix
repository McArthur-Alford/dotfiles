{ nixpkgs, ... }:
let
  user = "mmwave";
  password = "mmwave";
  hostname = "mmwave";
  overlays = [
    (_final: _super: { })
  ];
  system = "aarch64-linux";
  pkgs = import nixpkgs {
    inherit system;
  };
in
{
  nixpkgs.overlays = overlays;

  imports = [
    "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
  ];

  networking = {
    useDHCP = true;
    hostName = hostname;
    wireless = {
      enable = true;
      networks = { };
    };
  };

  environment.systemPackages = with pkgs; [ helix git ];
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

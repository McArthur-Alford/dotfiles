{ username, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sshfs ];

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
  users.users.${username}.openssh.authorizedKeys.keyFiles = [
    ../../../sshKeys/desktop.pub
    ../../../sshKeys/laptop.pub
    ../../../sshKeys/server.pub
    ../../../sshKeys/mosaic.pub
  ];
  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}

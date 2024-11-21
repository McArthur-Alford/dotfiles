{
  systemSettings,
  pkgs,
  self,
  ...
}:
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

  # A jank solution for the time being
  users.users = builtins.listToAttrs (
    map (username: {
      name = username;
      value = {
        openssh.authorizedKeys.keyFiles = [
          "${self}/assets/sshKeys/${username}/desktop.pub"
          "${self}/assets/sshKeys/${username}/laptop.pub"
          "${self}/assets/sshKeys/${username}/server.pub"
          "${self}/assets/sshKeys/${username}/mosaic.pub"
        ];
      };
    }) systemSettings.users
  );

  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}

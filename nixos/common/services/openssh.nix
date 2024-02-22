{ lib, ... }: {
  services = {
    openssh = {
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = lib.mkDefault "no";
        X11Forwarding = true;
      };
    };
  };
  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}

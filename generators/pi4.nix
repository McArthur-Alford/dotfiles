{ pkgs, inputs, ... }:
{
  # ----------- HARDWARE: -------------
  # imports = [
  #   inputs.nixos-hardware.nixosModules.raspberry-pi-4
  # ];
  # environment.systemPackages = with pkgs; [
  #   libraspberrypi
  #   raspberrypi-eeprom
  # ];

  # ---------- SSH: -------------
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

  # ----------- STATEVERSION: ----------
  system.stateVersion = "23.11";
}

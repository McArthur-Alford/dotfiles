{self, ...}:
{
  imports = [
    ./hardware.nix
    (self + "/nixos/common/hardware/systemd-boot.nix")
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 25566 3000 ];
    allowedUDPPortRanges = [
      { from = 25565; to = 25566; }
    ];
    allowedUDPPorts = [ 3000 ];
  };
}

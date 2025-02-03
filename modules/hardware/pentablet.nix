{ pkgs, config, ... }:
let
in
# xp_pen_pentablet = pkgs.callPackage ./xp_pen_pentablet.nix { };
{

  # services.xserver.digimend.enable = true;
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  environment.systemPackages = [
    # config.boot.kernelPackages.digimend
    pkgs.opentabletdriver
    # xp_pen_pentablet
  ];
}

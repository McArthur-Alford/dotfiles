{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.nh = {
    enable = true;
    # flake = /etc/nixos;
  };

  environment.sessionVariables = {
    FLAKE = lib.mkForce "/etc/nixos";
  };
}

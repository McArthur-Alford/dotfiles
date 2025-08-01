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
    NH_FLAKE = lib.mkForce "/etc/nixos";
  };
}

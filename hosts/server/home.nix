{ cfg, pkgs, libs, user, config, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/wofi/home.nix
  ];

  programs = {
  };

  home.packages = with pkgs; [
  ];
}

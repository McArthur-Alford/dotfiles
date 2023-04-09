{ config, lib, pkgs, host, user, ... }:
let
  workspaces = with host;
    if hostName == "desktop" then ''
      monitor=${toString mainMonitor},5120x1440@120,5140x0,1
    '' else "";
  monitors = with host;
    if hostName == "desktop" then ''
      workspaces=${toString mainMonitor},1
    '' else "";
  execute = with host;
    if hostName == "desktop" then ''
      
    '' else "";
in
{
  xdg.configFile."hypr/hyprland.conf".source = ../../../dotfiles/desktop/hypr/hyprland.conf;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = /home/${user}/wallpapers/wallpaper.png
      # .. more preloads

      wallpaper = DP-2,/home/${user}/wallpapers/wallpaper.png
      # .. more wallpapers
    '';
}

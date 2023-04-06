{ config, lib, pkgs, host, ... }:
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
}

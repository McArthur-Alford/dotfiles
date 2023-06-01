{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pkgs.eww-wayland
    libnotify
    mako
  ];
}
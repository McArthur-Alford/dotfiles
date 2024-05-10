{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libnotify
    playerctl
  ];
  services.mako = {
    enable = true;
    defaultTimeout = 3000;
  };
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ../../../dotfiles/eww;
    # configDir = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/desktop/eww;
  };
}

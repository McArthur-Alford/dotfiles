{ ... }:
{
  imports = [
    ./niri.home.nix
    ./hyprlock.home.nix
    ../programs/rofi.home.nix
    ../programs/lan-mouse.home.nix
    ../programs/kitty.home.nix
    ../services/xdg-mime.home.nix
    ../services/mako.home.nix
  ];
}

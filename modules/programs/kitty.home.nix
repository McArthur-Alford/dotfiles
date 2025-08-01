{ pkgs, lib, ... }:
{
  programs = {
    ghostty.enable = true;
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        package = lib.mkForce pkgs.fira-code-nerdfont;
        name = lib.mkForce "Fira Code Nerd Font";
        size = lib.mkForce 14;
      };
      settings = {
        background_opacity = lib.mkForce "1.0";
        background_blur = lib.mkForce "1";
        confirm_os_window_close = 0;
        disable_ligatures = "cursor";
      };
    };
  };
}

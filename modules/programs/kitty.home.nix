{ pkgs, lib, ... }:
{
  programs = {
    ghostty.enable = true;
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        package = lib.mkForce pkgs.nerd-fonts.fira-code;
        name = lib.mkForce "Fira Code Nerd Font";
        size = lib.mkForce 14;
      };
      settings = {
        background_opacity = lib.mkForce "0.95";
        background_blur = lib.mkForce "1";
        confirm_os_window_close = 0;
        disable_ligatures = "cursor";
      };
    };
  };
}

{ pkgs, lib, ... }:
{
  programs = {
    kitty = {
      enable = true;
      theme = "Dracula";
      shellIntegration.enableZshIntegration = true;
      font = {
        # package = pkgs.fira-code;
        # name = "Fira Code";
        size = lib.mkForce 14;
      };
      settings = {
        background_opacity = lib.mkForce "0.9";
        background_blur = lib.mkForce "10";
        confirm_os_window_close = 0;
        disable_ligatures = "never";
      };
    };
  };
}

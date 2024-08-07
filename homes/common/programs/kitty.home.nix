{ pkgs, lib, ... }:
{
  programs = {
    kitty = {
      enable = true;
      theme = "Dracula";
      shellIntegration.enableZshIntegration = true;
      # font = {
      #   package = pkgs.fira-code;
      #   name = "Fira Code";
      # };
      settings = {
        background_opacity = lib.mkForce "0.9";
        background_blur = lib.mkForce "10";
        confirm_os_window_close = 0;
      };
    };
  };
}

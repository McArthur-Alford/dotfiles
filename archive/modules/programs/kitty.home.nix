{ pkgs, ... }:
{
  programs = {
    kitty = {
      enable = true;
      theme = "Dracula";
      shellIntegration.enableZshIntegration = true;
      font = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
      settings = {
        # background_opacity = "0.9";
        # background_blur = "10";
        confirm_os_window_close = 0;
      };
    };
  };
}

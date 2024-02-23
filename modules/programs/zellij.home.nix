_:
{
  programs = {
    zellij = {
      enable = true;
      # enableZshIntegration = true;
      settings = {
        mouse_mode = true;
        pane_frames = false;
        theme = "dracula";
        themes.dracula.fg = "#f8f8f2";
        themes.dracula.bg = "#282a36";
        themes.dracula.black = "#282a36";
        themes.dracula.red = "#ff5555";
        themes.dracula.green = "#50fa7b";
        themes.dracula.yellow = "#f1fa8c";
        themes.dracula.blue = "#8be9fd";
        themes.dracula.magenta = "#ff79c6";
        themes.dracula.cyan = "#8be9fd";
        themes.dracula.white = "#ffffff";
        themes.dracula.orange = "#ffb86c";
      };
    };
  };
}

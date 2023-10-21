{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "dracula/zsh"; tags = [ "as:theme" "depth:1" ]; }
          { name = "plugins/colored-man-pages"; tags = [from:oh-my-zsh]; }
        ];
      };
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch = {
        enable = true;
      };
      shellAliases = {
        ls = "eza";
        cat = "bat";
        grep = "rga";
        find = "fd";
        diff = "delta";
        du = "dust";
        calc = "kalker";
      };
    };
    bat = {
      enable = true;
      themes = {
        dracula = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        } + "/Dracula.tmTheme");
      };
      config = {
        theme = "Dracula";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
    };
  };
}

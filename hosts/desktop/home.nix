{ cfg, pkgs, libs, user, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      helix = "nix run helix";
    };
    oh-my-zsh = {
      plugins = [ "git" ];
      theme = "bira";
    };
  };

  xdg.configFile."alacritty/alacritty.yml".source = ../../dotfiles/desktop/alacritty/alacritty.yml;
}
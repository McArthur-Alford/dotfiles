{ cfg, pkgs, libs, user, config, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/wofi/home.nix
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

  # Alacritty
  xdg.configFile."alacritty/alacritty.yml".source = ../../dotfiles/desktop/alacritty/alacritty.yml;

  # Helix
  xdg.configFile."helix/config.toml".source = ../../dotfiles/desktop/helix/config.toml;

  # Ranger
  xdg.configFile."ranger/rc.conf".source = ../../dotfiles/desktop/ranger/rc.conf;
  xdg.configFile."ranger/colorschemes/dracula.py".source = ../../dotfiles/desktop/ranger/colorschemes/dracula.py;
}
{ cfg, pkgs, libs, user, config, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/wofi/home.nix
  ];

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        helix = "nix run helix";
      };
      oh-my-zsh = {
        plugins = [ "git" ];
        theme = "bira";
      };
    };
    vscode = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    materia-kde-theme
    spotify
    spicetify-cli
    sway-contrib.grimshot
  ];

  # Alacritty
  xdg.configFile."alacritty/alacritty.yml".source = ../../dotfiles/desktop/alacritty/alacritty.yml;

  # Helix
  xdg.configFile."helix/config.toml".source = ../../dotfiles/desktop/helix/config.toml;

  # Ranger
  # xdg.configFile."ranger/rifle/rifle.conf".source = ../../dotfiles/desktop/ranger/rifle/rifle.conf;
  xdg.configFile."ranger/rc.conf".source = ../../dotfiles/desktop/ranger/rc.conf;
  xdg.configFile."ranger/colorschemes/dracula.py".source = ../../dotfiles/desktop/ranger/colorschemes/dracula.py;

  # QT5
  xdg.configFile."qt5ct/colors/Dracula.conf".source = ../../dotfiles/desktop/qt5ct/colors/Dracula.conf;

  # Spicetify
  xdg.configFile."spicetify".source = ../../dotfiles/desktop/spicetify;
}
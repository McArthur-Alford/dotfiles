{
  pkgs,
  inputs,
  system,
  ...
}:
{
  imports = [
    ./hyprland.home.nix
    ../programs/rofi.home.nix
    ../services/eww.home.nix
    ../programs/kitty.home.nix
    # ../services/swaylock.home.nix
    ../services/ags.home.nix
    ../services/xdg-mime.home.nix
  ];

  services.mako = {
    enable = true;
    defaultTimeout = 3000;
  };

  programs = {
    helix = {
      enable = true;
    };
    zathura = {
      enable = true;
      extraConfig = ''
        set synctex true
        set synctex-editor-command "texlab inverse-search -i %{input} -l %{line}"
      '';
    };
  };

  home.packages = with pkgs; [
    # inputs.matugen.packages.${system}.default
    jq
    playerctl
    brightnessctl
    acpi
    playerctl
    libnotify
  ];

  # home.pointerCursor = {
  #   name = "Dracula-cursors";
  #   package = pkgs.dracula-theme;
  #   size = 16;
  # };

  gtk = {
    enable = true;
    # theme = {
    #   name = "Dracula";
    #   package = pkgs.dracula-theme;
    # };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # font = {
    #   name = "FiraCode Nerd Font Mono Medium";
    # };
    gtk4.extraConfig = {
      settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  home.sessionVariables.GTK_THEME = "Dracula";

  # Helix
  # xdg.configFile."helix/config.toml".source = ../../../dotfiles/helix/config.toml;
  # xdg.configFile."helix/themes/alucard.toml".source = ../../../dotfiles/helix/themes/alucard.toml;
  # xdg.configFile."helix/languages.toml".source = ../../../dotfiles/helix/languages.toml;

  # Ranger
  xdg.configFile."ranger/rifle/rifle.conf".source = ../../../dotfiles/ranger/rifle/rifle.conf;
  xdg.configFile."ranger/rc.conf".source = ../../../dotfiles/ranger/rc.conf;
  xdg.configFile."ranger/colorschemes/dracula.py".source = ../../../dotfiles/ranger/colorschemes/dracula.py;

  # QT5
  xdg.configFile."qt5ct/colors/Dracula.conf".source = ../../../dotfiles/qt5ct/colors/Dracula.conf;

  # Vencord
  # xdg.configFile."BetterDiscord/plugins".source = ../../../dotfiles/BetterDiscord/plugins;
  # xdg.configFile."vesktop/themes".source = ../../../dotfiles/BetterDiscord/themes;

  # btop theme
  xdg.configFile."bashtop".source = ../../../dotfiles/bashtop;

  # Godot theme
  xdg.configFile."godot/themes".source = ../../../dotfiles/godot/themes;

}

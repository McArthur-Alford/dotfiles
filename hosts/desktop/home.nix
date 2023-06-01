{ cfg, pkgs, libs, user, config, spicetify-nix, ... }:
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/wofi/home.nix
    ../../modules/programs/spicetify.home.nix
    ../../modules/programs/zellij.home.nix
    ../../modules/programs/zsh.home.nix
  ];

  programs = {
    vscode = {
      enable = true;
    };
    zathura = {
      enable = true;
    };
    helix = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    # Dungeondraft/Wonderdraft (requires the .zip from humble bundle in the module directory)
    #(callPackage ../../modules/editors/wonderdraft/wonderdraft.nix {})
    #(callPackage ../../modules/editors/dungeondraft/dungeondraft.nix {})

    # Keyboard management for charybdis
    via
    vial
    qmk
    # qmk_hid
    qmk-udev-rules

    evince 
    texlab
    xorg.xhost

    materia-kde-theme
    sway-contrib.grimshot
    betterdiscordctl
    direnv
    nix-direnv
    
    libsForQt5.okular

    # Protonupqt
    protonup-ng

    # image editors
    gimp
    krita

    # Gparted (spooOoooky)
    gparted
    parted

    # Bitwarden!
    bitwarden

    # Obsidian!
    obsidian

    # keyring stuff
    gnome.gnome-keyring
    libsecret
    libgnome-keyring

    # Work Comms
    slack
    zoom-us

    # Office
    onlyoffice-bin

    # texlive
    texlive.combined.scheme-full

    # Libs
    dotnet-sdk_7

    # Jetbrains
    jetbrains.idea-community

    # Element
    element-desktop
  ];

  # mimetypes
  #xdg.mimeApps = {
    #enable  = true;
    #associations.added = {
      #"applications/pdf" = ["org.gnome.Zathura.desktop"];
      ##"image/*" = ["org.gnome.Feh.desktop"];
    #};
    #defaultApplications = {
      #"applications/pdf" = ["org.gnome.Zathura.desktop"];
      ##"image/*" = ["org.gnome.Feh.desktop"];
    #};
  #};

  # GTK Theme
  gtk = {		# GTK Theme
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "FiraCode Nerd Font Mono Medium";
    };
    gtk4.extraConfig = {
      settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  home.sessionVariables.GTK_THEME = "Dracula";

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

  # Better Discord
  xdg.configFile."BetterDiscord/plugins".source = ../../dotfiles/desktop/BetterDiscord/plugins;
  xdg.configFile."BetterDiscord/themes".source = ../../dotfiles/desktop/BetterDiscord/themes;

  # btop theme
  xdg.configFile."bashtop".source = ../../dotfiles/desktop/bashtop;

  # Godot theme
  xdg.configFile."godot/themes".source = ../../dotfiles/desktop/godot/themes;
}

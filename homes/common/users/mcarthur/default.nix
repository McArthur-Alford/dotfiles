{ pkgs, ... }:
{
  imports = [
    ../../programs/spotify.home.nix
    ../../programs/firefox.home.nix
    ../../programs/fastfetch.home.nix
  ];

  home.packages = with pkgs; [
    # Terminal
    btop # Resource Management
    ranger # File management
    unzip # Unzipper

    # Video/Audio
    feh # Image Viewer
    mpv # Media Player
    obs-studio # Recording
    pavucontrol # Audio Control
    vlc # Media Player

    # Apps
    appimage-run

    # comma
    comma
    # Dungeondraft/Wonderdraft (requires the .zip from humble bundle in the module directory)
    #(callPackage ../../modules/editors/wonderdraft/wonderdraft.nix {})
    #(callPackage ../../modules/editors/dungeondraft/dungeondraft.nix {})

    # git
    gh
    git-lfs

    jetbrains.rust-rover

    zotero_7

    evince
    xorg.xhost

    materia-kde-theme
    sway-contrib.grimshot
    satty
    betterdiscordctl

    libsForQt5.okular

    # image editors
    gimp
    krita

    # Bitwarden!
    bitwarden

    # Obsidian!
    obsidian

    # keyring stuff
    # TODO is this necessary?
    gnome.gnome-keyring
    libsecret
    libgnome-keyring

    # Work Comms
    slack
    zoom-us

    # Office
    onlyoffice-bin

    # texlive
    # texlive.combined.scheme-full

    anki-bin
    gnome.nautilus
    usbutils
    xorg.libXxf86vm
    nautilus-open-any-terminal
    libsForQt5.qt5ct
    dnsmasq
    wineWowPackages.stable
    winetricks
    polkit
    qsynth
    radeontop
  ];
}

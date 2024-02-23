{ pkgs, ... }:
{
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
    google-chrome
    firefox

    # comma
    comma
    # Dungeondraft/Wonderdraft (requires the .zip from humble bundle in the module directory)
    #(callPackage ../../modules/editors/wonderdraft/wonderdraft.nix {})
    #(callPackage ../../modules/editors/dungeondraft/dungeondraft.nix {})
    gh

    protonmail-bridge
    thunderbird

    git-lfs

    # fan control stuff
    lm_sensors
    liquidctl

    # Keyboard management for charybdis
    via
    vial
    qmk
    # qmk_hid
    qmk-udev-rules

    evince
    # texlab
    xorg.xhost

    materia-kde-theme
    sway-contrib.grimshot
    satty
    betterdiscordctl

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
    # texlive.combined.scheme-full

    # Libs
    dotnet-sdk_7

    # Element
    element-desktop
  ];
}

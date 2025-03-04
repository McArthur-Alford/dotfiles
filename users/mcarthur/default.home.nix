{
  pkgs,
  self,
  inputs,
  systemSettings,
  ...
}:
{
  imports = [
    "${self}/modules/programs/spotify.home.nix"
    "${self}/modules/programs/firefox.home.nix"
    "${self}/modules/programs/fastfetch.home.nix"
    "${self}/modules/programs/zathura.home.nix"
    "${self}/modules/programs/vencord.home.nix"
    "${self}/modules/programs/nixcord.home.nix"
    "${self}/modules/terminal/alucard.home.nix"
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
    easyeffects
    vlc # Media Player

    inputs.zen-browser.packages."${systemSettings.system}".default

    # Apps
    appimage-run
    protonmail-desktop
    protonmail-bridge
    protonmail-bridge-gui

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
    # gnome-keyring
    # libsecret
    # libgnome-keyring

    # Work Comms
    slack
    zoom-us

    # Office
    onlyoffice-bin

    # texlive
    # texlive.combined.scheme-full

    # Pomodoro!!!
    pomodoro-gtk

    anki-bin
    nautilus
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

    # Other random stuff that may or may not be used
    brightnessctl
    acpi
    playerctl
  ];
}

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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  home.packages = with pkgs; [
    devenv
    zed-editor

    uv
    # ty
    # ruff
    # python313Packages.python-lsp-server
    # python313Packages.jedi-language-server

    # Terminal
    btop-rocm # Resource Management
    ranger # File management
    unzip # Unzipper

    # Video/Audio
    feh # Image Viewer
    mpv # Media Player
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
    jujutsu

    # jetbrains.rust-rover

    zotero_7

    evince
    xorg.xhost

    materia-kde-theme
    sway-contrib.grimshot
    satty

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

    rclone
  ];
}

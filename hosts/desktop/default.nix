{ config, pkgs, user, system, lib, ...}:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/desktop/hyprland 
    # ../../modules/programs/eww.nix
    ../../modules/programs/waybar.nix
    ../../modules/programs/wofi
    ../../modules/programs/python.nix
    ../../modules/programs/docker.nix
    ../../modules/programs/haskell.nix
    ../../modules/programs/godot.nix
    (import ../../modules/programs/discord.nix {
      inherit pkgs;
      discordHash = "04r1yx6aqd4f4lq7wfcgs3jfpn40gz7gwajzai1aqz12ny78rs7z";
    })
    ../../modules/services/gnome-keyring.nix
    ../../modules/kernels/latest.nix
    ../../modules/services/systemd-boot.nix
    # ../../modules/gpu/amd.nix
    ../../modules/programs/zsh.nix
  ];

  hardware.keyboard.qmk.enable = true;
  i18n.inputMethod = {
    enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
      ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 25565 25566 ];
    allowedUDPPortRanges = [
      { from = 25565; to = 25566; }
    ];
  };

 
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      carlito
      dejavu_fonts
      ipafont
      kochi-substitute
      source-code-pro
      ttf_bitstream_vera
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
        "IPAGothic"
      ];
      sansSerif = [
        "DejaVu Sans"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };
  };  


  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  environment = {
    systemPackages = with pkgs; [					# Packages not offered by Home-Manager
      # Dungeondraft/Wonderdraft
      # (callPackage ../../modules/editors/wonderdraft/wonderdraft.nix {})
      (callPackage ../../modules/editors/dungeondraft/dungeondraft.nix {})
      # (callPackage ../../weird.nix {})
      pipewire

      anki-bin

      xorg.libXxf86vm

      # Screen recording!
      gpu-screen-recorder
      gpu-screen-recorder-gtk

      freshfetch
      steam
      lutris
      gnome.nautilus
      nautilus-open-any-terminal
      libsForQt5.qt5ct
      gamescope

      mangohud

      # wine
      wineWowPackages.stable
      winetricks

      pandoc

      # polkit
      polkit

      # Blender
      blender
      qsynth

      # Jetbrains
      jetbrains.idea-community

      # Minecraft
      prismlauncher

      # AMD Rocm experimentation TODO trim this, a lot is uncessary
      # rocm-smi
      # radeontop
      # rocm-opencl-icd
      # amdvlk
      # rocminfo
      # miopengemm
      # rocm-cmake
      # boost
      # sqlite
      # rocblas
      # rocmlir
      # llvmPackages_rocm.llvm
      # llvmPackages_rocm.clang
      # llvmPackages_rocm.rocmClangStdenv
    ];

    etc."spotify".source = "${pkgs.spotify}"; # Spotify fixed path for spicetify to use
  };

  programs = {
    steam = {
      enable = true;
      # gamescopeSession = {
      #   enable = true;
      # };
    };
    gamemode.enable = true;						# Better performance
    									                # Steam: Launch Options: gamemoderun %command%
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  # Disable autosleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

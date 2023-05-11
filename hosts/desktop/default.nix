{ config, pkgs, user, system, ...}:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/desktop/hyprland 
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
    ../../modules/gpu/amd.nix
    ../../modules/programs/zsh.nix
  ];
 
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [					# Packages not offered by Home-Manager
      freshfetch
      steam
      libsForQt5.dolphin
      gnome.nautilus
      nautilus-open-any-terminal
      libsForQt5.qt5ct

      # polkit
      polkit

      # Blender
      blender
      qsynth

      # AMD Rocm TODO trim this, a lot is uncessary
      rocm-smi
      radeontop
      rocm-opencl-icd
      amdvlk
      rocminfo
      miopengemm
      rocm-cmake
      boost
      sqlite
      rocblas
      rocmlir
      llvmPackages_rocm.llvm
      llvmPackages_rocm.clang
      llvmPackages_rocm.rocmClangStdenv
    ];

    etc."spotify".source = "${pkgs.spotify}"; # Spotify fixed path for spicetify to use
  };

  programs = {
    steam.enable = true;
    gamemode.enable = true;						# Better performance
    									                # Steam: Launch Options: gamemoderun %command%
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

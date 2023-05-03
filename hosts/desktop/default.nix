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
   ];

  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;

  # auto usb mounting stuff
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;				# Kernel 

    initrd.kernelModules = ["amdgpu"];					# Video Drivers

    loader = {
      systemd-boot = {
        enable = true;
      	configurationLimit = 5;						# Limit amount of configurations
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      timeout = 5;							# Grub auto select time
    };
  };

  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [					# Packages not offered by Home-Manager
      discord
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

    shells = with pkgs; [ bash zsh ];

    etc."spotify".source = "${pkgs.spotify}"; # Spotify fixed path for spicetify to use
  };

  programs = {
    steam.enable = true;
    # gamemode.enable = true;						# Better performance
    									# Steam: Launch Options: gamemoderun %command%
    zsh.enable = true;
  };
  users.users.${user}.shell = pkgs.zsh;
  
  nixpkgs.overlays = [							# Keeps discord up to date
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { 
          src = builtins.fetchTarball {
      	  url = "https://discord.com/api/download?platform=linux&format=tar.gz";
      	  sha256 = "04r1yx6aqd4f4lq7wfcgs3jfpn40gz7gwajzai1aqz12ny78rs7z";
        };}
      );
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  services = {
    blueman.enable = true;
    xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      displayManager.defaultSession = "hyprland";

      videoDrivers = [
        "amdgpu"
      ];
    };
  };

  # --- AMD GPU ---
  nixpkgs.config.rocmTargets = [ "gfx1030" ];
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
    vulkan-tools
    miopengemm
    rocm-cmake
    llvmPackages_rocm.llvm
    llvmPackages_rocm.clang
    llvmPackages_rocm.rocmClangStdenv
  ];
  hardware.opengl.driSupport = true;

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

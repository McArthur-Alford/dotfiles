{ config, pkgs, user, system, ...}:
let
  intelBusId = "PCI:01:00:0";
  nvidiaBusId = "PCI:00:02:0";
in
{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/desktop/hyprland 
    ../../modules/programs/wofi
    ../../modules/programs/python.nix
    ../../modules/programs/docker.nix
    ../../modules/programs/haskell.nix
    ../../modules/programs/godot.nix
    ../../modules/programs/discord.nix
    ../../modules/services/gnome-keyring.nix
    ../../modules/kernels/latest.nix
    ../../modules/services/systemd-boot.nix
    (import ../../modules/gpu/nvidia-optimus.nix {inherit pkgs config intelBusId nvidiaBusId;})
   ];

  # auto usb mounting stuff
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
  
  services = {
    blueman.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

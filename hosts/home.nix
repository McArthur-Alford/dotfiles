{ config, pkgs, lib, user, ... }:
{
  imports = [ ];

  programs.home-manager.enable = true;
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  
  home.stateVersion = "22.11";
  
  home.packages = with pkgs; [
    # Terminal
    btop	  # Resource Management
    ranger	# File management
    unzip   # Unzipper

    # Video/Audio
    feh			# Image Viewer
    mpv			# Media Player
    obs-studio 		# Recording
    pavucontrol 	# Audio Control
    vlc			# Media Player

    # Apps
    appimage-run
    google-chrome

    # 
    cargo
    rustc
  ];

  programs.bash = {
    shellAliases = {
      helix = "nix run helix";
    };
  };

  xsession.enable = true;
  home.pointerCursor = {
    name = "Dracula-cursors";
    package = pkgs.dracula-theme;
    size = 16;
  };
  
  home.file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../modules/themes/wall;
}

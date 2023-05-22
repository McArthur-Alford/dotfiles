# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, user, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/desktop/hyprland 
      ../../modules/programs/wofi
      ../../modules/programs/docker.nix
      ../../modules/programs/python.nix
      ../../modules/programs/haskell.nix
      ../../modules/programs/zsh.nix
      ../../modules/services/gnome-keyring.nix
      ../../modules/kernels/latest.nix
      ../../modules/gpu/nvidia.nix
      # ../../modules/services/systemd-boot.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/md126"; # or "nodev" for efi only

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 3000 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services = {
    xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
        autoSuspend = false;
      };

      displayManager.defaultSession = "hyprland";
    };
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  # auto usb mounting stuff
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking = {
    hostName = "nixos-server";
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [					# Packages not offered by Home-Manager
      freshfetch
      gnome.nautilus
      nautilus-open-any-terminal
      libsForQt5.qt5ct
    ];
  };

  # Not sure if this is necessary to disable autosuspend, but keep it anyway
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
  powerManagement.enable = false;

  system.stateVersion = "22.11"; # Did you read the comment?
}

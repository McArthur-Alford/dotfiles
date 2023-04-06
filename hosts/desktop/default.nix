{ config, pkgs, user, system, ...}:

{
  imports = [ ../../modules/desktop/hyprland ];

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
      timeout = 3;							# Grub auto select time
    };
  };

  networking = {
    hostName = "nixos-desktop";
    networkmanager.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [					# Packages not offered by Home-Manager
      discord
    ];
  };

  programs = {
    # steam.enabled = true;
    # gamemode.enable = true;						# Better performance
    									# Steam: Launch Options: gamemoderun %command%
  };
  
  nixpkgs.overlays = [							# Keeps discord up to date
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { src = builtins.fetchTarball {
	  url = "https://discord.com/api/download?platform=linux&format=tar.gz";
	  sha256 = "04r1yx6aqd4f4lq7wfcgs3jfpn40gz7gwajzai1aqz12ny78rs7z";
	};}
      );
    })
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
}

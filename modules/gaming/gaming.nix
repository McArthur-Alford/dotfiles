## NOTE:
## This is only configured for AMD GPUs; Nvidia might require additional configuration.
## For example host (PC) configuration using this module go to hosts/x86/rune
{
  pkgs,
  lib,
  config,
  inputs,
  self,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Steam controller and input stuff
  hardware.steam-hardware.enable = true;

  # fix for fromsoft games that struggle with my E-Cores :)
  powerManagement.cpuFreqGovernor = "performance";

  environment.systemPackages = with pkgs; [
    lact # AMDgpu tool
    gamescope
    # gamescope-wsi # TODO: Test again in future updates, borked atm 06/21/25
  ];

  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

  # temporary capsysnice fix?
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };

  programs = {
    gamescope = {
      package = pkgs.gamescope;
      enable = true;
      capSysNice = false;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      protontricks = {
        enable = true;
        package = pkgs.protontricks;
      };

      extest.enable = true;

      package = pkgs.steam.override {
        extraPkgs =
          pkgs:
          (builtins.attrValues {
            inherit (pkgs.xorg)
              libXcursor
              libXi
              libXinerama
              libXScrnSaver
              ;

            inherit (pkgs.stdenv.cc.cc)
              lib
              ;

            inherit (pkgs)
              gamemode
              mangohud
              gperftools
              keyutils
              libkrb5
              libpng
              libpulseaudio
              libvorbis
              ;
          });
      };
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      gamescopeSession.enable = true;
    };

    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          inhibit_screensaver = 1;
          renice = 15;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 1; # The DRM device number on the system (usually 0), ie. the number in /sys/class/drm/card0/
          amd_performance_level = "high";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
}

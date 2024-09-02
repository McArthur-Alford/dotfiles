{
  pkgs,
  lib,
  config,
  inputs,
  system,
  username,
  ...
}:
{
  environment = {
    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
      swww
      qt6.full
      xwayland
      xdg-utils
    ];
    etc."greetd/environments".text = ''
      Hyprland
    '';

  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "*" ];
      hyprland.default = [
        "hyprland"
        "gtk"
      ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-wlr
      # pkgs.xdg-desktop-portal-hyprland
    ];
  };

  services = {
    blueman.enable = true;
    fprintd.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          # command = "
          #   dbus-run-session ${pkgs.cage}/bin/cage -s -- ${lib.getExe config.programs.regreet.package}
          # ";
          command = "${inputs.hyprland.packages.${system}.default}/bin/Hyprland";
          user = "${username}";
        };
        default_session = initial_session;
      };
    };
  };

  programs = {
    regreet = {
      enable = true;
      # settings = ./regreet-config.toml;
    };
    hyprland = {
      package = inputs.hyprland.packages.${system}.default;
      enable = true;
    };
    # hyprlock = {
    #   enable = true;
    # };
    xwayland.enable = true;
  };
}

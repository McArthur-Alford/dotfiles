{ pkgs, username, lib, config, ... }:
let
  tuigreetBin = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland = config.programs.hyprland.package;
  hyprlandBin = "${hyprland}/bin/Hyprland";
  hyprland-sessions = "${hyprland}/share/wayland-sessions";
in
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
    };
    systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      grim
      mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
      swww
      qt6.full
      xwayland
    ];
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

  services = {
    blueman.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "
            ${tuigreetBin} --theme border=magenta;text=white;prompt=green;time=red;action=magenta;button=yellow;container=black;input=cyan --time --asterisks --remember --cmd ${hyprlandBin} --remember-session --sessions ${hyprland-sessions} 
          ";
          user = "greeter";
        };
      };
    };
  };

  programs = {
    hyprland = {
      enable = true;
    };
    xwayland.enable = true;
  };
}

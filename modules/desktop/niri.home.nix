{
  pkgs,
  inputs,
  config,
  self,
  systemSettings,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
    "${self}/modules/services/hyprlock.home.nix"
    "${self}/modules/services/hypridle.home.nix"
    # "${self}/modules/programs/rofi.home.nix"
    "${self}/modules/programs/anyrun.home.nix"
    "${self}/modules/programs/lan-mouse.home.nix"
    "${self}/modules/programs/kitty.home.nix"
    "${self}/modules/services/xdg-mime.home.nix"
    "${self}/modules/services/mako.home.nix"
  ];
  services.swww.enable = true;
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
  programs.niri.settings = {
    prefer-no-csd = true;

    spawn-at-startup = [
      {
        command = [
          "dbus-update-activation-environment"
          "--systemd"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      }
      { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
      { command = [ "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" ]; }
      { command = [ "${pkgs.hypridle}/bin/hypridle" ]; }
      # { command = [ "${pkgs.hyprlock}/bin/hyprlock" ]; }
      {
        command = [
          "swww-daemon"
        ];
      }
    ];

    input = {
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus = true;
    };

    outputs."HDMI-A-1".scale = 1.0;
    outputs."HDMI-A-1".variable-refresh-rate = true;
    outputs."eDP-1".scale = 1.2;
    outputs."eDP-1".variable-refresh-rate = true;

    environment = {
      QT_QPA_PLATFORM = "wayland";
      DISPLAY = ":0";
    };

    layout = {
      focus-ring = {
        enable = false;
        width = 1;
      };
      border = {
        enable = false;
        width = 2;
      };
      gaps = 5;
      struts = {
        bottom = 1;
        top = 1;
        left = 1;
        right = 1;
      };
    };

    overview.backdrop-color = "#282A36";

    window-rules = [
      {
        matches = [
          # { app-id = "firefox"; }
          { app-id = "vesktop"; }
        ];
        block-out-from = "screencast";
      }
      {
        matches = [
          { app-id = "planets"; }
        ];
        open-floating = true;
      }
      {
        matches = [ { app-id = "^kitty$"; } ];
        default-column-width.proportion = if (systemSettings.hostname == "thaumaturge") then 0.25 else 0.5;
      }
    ];

    binds = with config.lib.niri.actions; rec {
      "Mod+C".action = close-window;
      "Mod+S".action = screenshot;
      "Mod+Period".action = consume-or-expel-window-right;
      "Mod+Comma".action = consume-or-expel-window-left;
      "Mod+F".action = fullscreen-window;
      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Q".action = spawn "kitty";
      # "Mod+D".action = spawn "rofi" "-show" "drun";
      "Mod+D".action = spawn "anyrun";
      "Mod+Escape".action = spawn "hyprlock";
      "Mod+Shift+M".action = quit { skip-confirmation = true; };
      "Mod+E".action = center-column;
      # Navigation:
      "Mod+H".action = focus-column-left-or-last;
      "Mod+L".action = focus-column-right-or-first;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;
      # Moving Windows:
      "Mod+Shift+H".action = move-column-left-or-to-monitor-left;
      "Mod+Shift+L".action = move-column-right-or-to-monitor-right;
      "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;
      "Mod+Ctrl+K".action = move-column-to-workspace-up;
      "Mod+Ctrl+J".action = move-column-to-workspace-down;
      # Resizing Windows:
      "Mod+Minus".action = set-column-width "-5%";
      "Mod+Equal".action = set-column-width "+5%";
      "Mod+Plus".action = set-column-width "+5%";
      "Mod+Shift+Minus".action = set-window-height "-5%";
      "Mod+Shift+Equal".action = set-window-height "+5%";
      "Mod+Shift+Plus".action = set-window-height "+5%";
      # Workspace Navigation:
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+0".action = focus-workspace 0;
      # Rearranging Workspaces:
      "Mod+Ctrl+Shift+J".action = move-workspace-down;
      "Mod+Ctrl+Shift+K".action = move-workspace-up;
      # Floating Windows:
      "Mod+G".action = toggle-window-floating;
    };
  };
}

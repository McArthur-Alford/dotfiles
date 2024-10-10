{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix
  ];
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
      { command = [ "${pkgs.hypridle}/bin/hypridle" ]; }
      { command = [ "swww init" ]; }
      { command = [ "${pkgs.hyprlock}/bin/hyprlock" ]; }
    ];

    input = {
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus = true;
    };

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
      "Mod+D".action = spawn "rofi" "-show" "drun";
      "Mod+Escape".action = spawn "hyprlock";
      "Mod+Shift+M".action = quit { skip-confirmation = true; };
      "Mod+E".action = center-column;
      # Navigation:
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+K".action = focus-window-up;
      "Mod+J".action = focus-window-down;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;
      # Moving Windows:
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+K".action = move-window-up;
      "Mod+Shift+J".action = move-window-down;
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
      # Workspace Navigation
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
      # Rearranging Workspaces
      "Mod+Ctrl+Shift+J".action = move-workspace-down;
      "Mod+Ctrl+Shift+K".action = move-workspace-up;
    };
  };
}

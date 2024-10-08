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
    input = {
      focus-follows-mouse.enable = true;
      warp-mouse-to-focus = false;
    };

    binds = with config.lib.niri.actions; rec {
      "Mod+C".action = close-window;
      "Mod+S".action = screenshot;
      "Mod+Period".action = consume-or-expel-window-left;
      "Mod+Comma".action = consume-or-expel-window-right;
      "Mod+F".action = fullscreen-window;
      "Mod+WheelScrollDown" = focus-workspace-down;
      "Mod+WheelScrollUp" = focus-workspace-up;
      "Mod+WheelScrollRight" = focus-column-right;
      "Mod+WheelScrollLeft" = focus-column-left;
      "Mod+Q".action = spawn "kitty";
      "Mod+D".action = spawn "rofi" "-show" "drun";
      "Mod+Shift+M".action = quit { skip-confirmation = true; };
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+K".action = focus-window-up;
      "Mod+J".action = focus-window-down;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+K".action = move-window-up;
      "Mod+Shift+J".action = move-window-down;
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
    };
  };
}

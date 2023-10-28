{system, host, inputs, ... }:
let
  workspaces = with host;
    if hostName == "desktop" then ''
      monitor=${toString mainMonitor},5120x1440@120,5140x0,1
    '' else if hostName == "laptop" then ''
      monitor=${toString mainMonitor},3840x2160@60,3840x0,1
    '' else "";
in
{
  # xdg.configFile."hypr/hyprland.conf".source = ../../../dotfiles/desktop/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprmonitors.conf".text = workspaces;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.default;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "~/.config/hypr/hyprmonitors.conf"
        "swww init"
        # "if ! [ command nm-applet ] then nm-applet --indicator fi"
      ];
      exec = [
        "pkill .eww-wrapped && eww open bar"
        "eww daemon"
        # "eww reload"
      ];

      env = "XCURSOR_SIZE,24";

      input = {
        kb_layout = "us";
        follow_mouse = "1";

        touchpad = {
          natural_scroll = "no";
          disable_while_typing = "false";
        };

        sensitivity = "0";
      };

      general = {
        gaps_in = "5";
        gaps_out = "10";
        border_size = "2";
        "col.inactive_border" = "rgba(50fa7b20) rgba(ff555520) 90deg";
        "col.active_border" = "rgba(50fa7b80) rgba(ff79c680) 90deg";
        layout = "dwindle";
      };

      decoration = {
        rounding = "10";

        blur = {
          enabled = "true";
          size = "3";
          passes = "3";
          noise = "0.0025";
          contrast = "1";
          new_optimizations = "true";
        };

        "col.shadow" = "rgba(1E202966)";
        drop_shadow = "yes";
        shadow_range = "60";
        shadow_offset = "1 2";
        shadow_render_power = "3";
        shadow_scale = "0.97";
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows,     1, 10, myBezier"
          # "windowsOut,  1, 10, default"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default, slidevert"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_is_master = "true";
      };

      gestures = {
        workspace_swipe = "off";
      };

      device = { 
        "epic-mouse-v1" = {
          sensitivity = "-0.5";
        };
      };

      windowrule = [
        "float,^(Matplotlib)$"
        "float,^(vampireSurvivors)$"
        "float,^(spacegame)$"
        "float,^(arcade_platformer)$"
        "float,title:^(winit window)$"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, alacritty"
        "$mainMod, C, killactive,"
        "$mainMod, S, exec, grimshot copy area"
        "$mainMod, B, exec, pkill waybar || waybar"

        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, P, pseudo,"
        "$mainMod CTRL, J, togglesplit,"
        "$mainMod, F, fullscreen"

        # Move focus with mainMod + arrow keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e-1"
        "$mainMod, mouse_up, workspace, e+1"

        # Move/resize windows with mainMod + LMB/RMB and dragging
        # "$mainMod, mouse:272, movewindow"
        # "$mainMod, mouse:273, resizewindow"

        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
 
    };
  };
}

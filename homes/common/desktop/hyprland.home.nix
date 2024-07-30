{
  hostname,
  inputs,
  system,
  pkgs,
  ...
}:
let
  workspaces =
    if hostname == "thaumaturge" then
      ''
        monitor=MAIN,5120x1440@240,0x0,1
      ''
    else if hostname == "grimoire" then
      ''
        monitor=MAIN,3840x2160@60,3840x0,1
      ''
    else
      "";
in
{
  # xdg.configFile."hypr/hyprland.conf".source = ../../../dotfiles/hypr/hyprland.conf;
  xdg.configFile."hypr/hyprmonitors.conf".text = workspaces;

  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    #SDL_VIDEODRIVER = "x11";
    CLUTTER_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.default;
    xwayland.enable = true;
    systemd.enable = true;

    # plugins = [ inputs.Hyprspace.packages.${system}.Hyprspace ];
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # ...
    ];

    settings = {
      misc = {
        vrr = 1;
      };

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "~/.config/hypr/hyprmonitors.conf"
        "swww init"
        # "if ! [ command nm-applet ] then nm-applet --indicator fi"
      ];
      exec = [
        "unset NIXOS_XDG_OPEN_USE_PORTAL"
        "env WLR_NO_HARDWARE_CURSORS=1"
        # "pkill .eww-wrapped && eww open bar"
        # "eww daemon"
        # "eww reload"
        # "wal -R"
      ];

      env =
        [
          "XCURSOR_SIZE,24"
          # "WLR_NO_HARDWARE_CURSORS,1"
        ]
        ++ (
          if hostname == "grimoire" then
            [
              "LIBVA_DRIVER_NAME,nvidia"
              "XDG_SESSION_TYPE,wayland"
              "GBM_BACKEND,nvidia-drm"
              "__GLX_VENDOR_LIBRARY_NAME,nvidia"
              "WLR_NO_HARDWARE_CURSORS,1"
            ]
          else
            [ ]
        );

      input = {
        kb_layout = "us";
        follow_mouse = "1";

        # mouse_refocus = "1";

        touchpad = {
          natural_scroll = "no";
          disable_while_typing = "false";
        };

        sensitivity = "0";
      };

      general = {
        gaps_in = "2";
        gaps_out = "0";
        border_size = "0";
        "col.inactive_border" = "rgba(44475A00)"; # rgba(ff555520) 90deg";
        "col.active_border" = "rgba(6272A4FF)"; # rgba(ff79c680) 90deg";
        layout = "dwindle";
      };

      decoration = {
        rounding = "1";

        blur = {
          enabled = "true";
          size = "5";
          passes = "2";
          noise = "0.0125";
          contrast = "1.0";
          brightness = "1.0";
          vibrancy = "1.0";
          new_optimizations = "true";
        };

        "col.shadow" = "rgba(1E202966)";
        drop_shadow = "yes";
        shadow_range = "60";
        shadow_offset = "1 2";
        shadow_render_power = "10";
        shadow_scale = "0.97";
      };

      animations = {
        enabled = "true";

        animation = [
          "windows,1,8,default,popin 90%"
          "windowsMove,1,0.4,default"
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
        no_gaps_when_only = 1;
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = "off";
      };

      # device = { 
      #   "epic-mouse-v1" = {
      #     sensitivity = "-0.5";
      #   };
      # };

      windowrule = [
        "float,^(Matplotlib)$"
        "float,^(vampireSurvivors)$"
        "float,^(spacegame)$"
        "float,^(arcade_platformer)$"
        "float,title:^(winit window)$"
        "float,^(pathfinder)"
      ];

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
      ];

      "$mainMod" = "SUPER";

      bindl = [ ",switch:on:Lid Switch,exec,systemctl suspend" ];

      bind = [
        # "$mainMod, W, overview:toggle"
        # "$mainMod, W, hyprexpo:expo, toggle"
        "$mainMod, Q, exec, kitty"
        "$mainMod, C, killactive,"
        # "$mainMod, S, exec, grimshot copy area"
        ''$mainMod, S, exec, grim -g "$(slurp)" - | wl-copy''
        ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | satty --filename -''
        # ''$mainMod, S, exec, grim -g "$(slurp -o -r -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png''
        "$mainMod, B, exec, pkill waybar || waybar"

        "$mainMod CTRL, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, rofi -show drun"
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

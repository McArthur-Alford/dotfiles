{ config, lib, pkgs, host, user, ...}:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  nixpkgs.overlays = [                                      # Waybar needs to be compiled with the experimental flag for wlr/workspaces to work (for now done with hyprland.nix)
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        patchPhase = ''
          substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
        '';
      });
    })
  ];

  home-manager.users.${user} = {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
      };

      style = ''
        @define-color background-darker rgba(30, 31, 41, 230);
        @define-color background #282a36;
        @define-color background-bright #3c3f52;
        @define-color selection #44475a;
        @define-color foreground #f8f8f2;
        @define-color comment #6272a4;
        @define-color cyan #8be9fd;
        @define-color green #50fa7b;
        @define-color orange #ffb86c;
        @define-color pink #ff79c6;
        @define-color purple #bd93f9;
        @define-color red #ff5555;
        @define-color yellow #f1fa8c;
        @define-color transparent rgba(20, 31, 41, 0);
        * {
            border: none;
            border-radius: 0;
            font-family: Iosevka;
            font-size: 11pt;
            min-height: 0;
        }
        window#waybar {
            margin-top: 4px;
            background: none;
            color: @foreground;
        }
        window > box {
          margin-top: 8px;
          background: none;
        }
        .modules-center {
          border-radius: 10;
          background: @background;
        }
        #workspaces {
          border-radius: 10 0 0 10;
          padding-left: 15px;
          padding-right: 0px;
          margin-right: 5px;
          background: @background-bright;
        }
        #workspaces button {
            background: @background-bright;
            color: @foreground;
            /* border-bottom: 2px solid @foreground;*/
        }
        #workspaces button:hover {
            box-shadow: inherit;
            text-shadow: inherit;
            background: @green;
            color: @background-darker;
            /*border-bottom: 2px solid @background-darker;*/
        }
        #workspaces button.active {
            background: @green;
            color: @background-darker;
            /* border-bottom: 2px solid @background-darker; */
        }
        #clock {
          color: @purple;
          padding-right: 8px;
          padding-left: 8px;
          margin-right: 15px;
        }
        #pulseaudio {
          color: @green;
          padding-left: 8px;
          margin-left: 8px;
        }
        #tray {
          padding-left: 5px;
          margin-left: 8px;
        }
        #network {
          color: @red;
          padding-left: 8px;
          margin-left: 8px;
        }
        #cpu {
          padding-left: 8px;
          margin-left: 8px;
        }
        #memory {
          padding-left: 8px;
          margin-left: 8px;
          padding-right: 8px;
          margin-right: 8px;
        }
      '';

      settings = {
        Main = {
          layer = "top";
          position = "top";
          height = 40;
          width = 400;
          tray = { spacing = 7; };
          modules-left = [ ];
          modules-right = [ ];
          modules-center = [ "wlr/workspaces" "tray" "pulseaudio" "clock"];
          "wlr/workspaces" = {
            format = "<span font='11'>{icon}</span>";
            all-outputs = true;
            active-only = false;
            on-click = "activate";
          };
          clock = {
            format = " {:%b %d %y %H:%M}";
          };
          cpu = {
            format = " {usage}% <span font='11'></span> ";
            interval = 1;
          };
          disk = {
            format = "{percentage_used}% <span font='11'></span>";
            path = "/";
            interval = 30;
          };
          memory = {
            format = "{}% <span font='11'></span>";
            interval = 1;
          };
          backlight = {
            device = "intel_backlight";
            format= "{percent}% <span font='11'>{icon}</span>";
            format-icons = ["" ""];
            on-scroll-down = "${pkgs.light}/bin/light -U 5";
            on-scroll-up = "${pkgs.light}/bin/light -A 5";
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% <span font='11'>{icon}</span>";
            format-charging = "{capacity}% <span font='11'></span>";
            format-icons = ["" "" "" "" ""];
            max-length = 25;
          };
          network = {
            format-ethernet = "Eth: {ipaddr}/{cidr}";
            format-linked = "<span font='11'>睊</span> {ifname} (No IP)";
            format-disconnected = "<span font='11'>睊</span> Not connected";
            on-click-right = "nm-applet";
          };
          pulseaudio = {
            format = "{volume}% {format_source} ";
            format-source = "<span font='10'></span> ";
            format-source-muted = "<span font='11'></span> ";
            tooltip-format = "{desc}, {volume}%";
            on-click = "${pkgs.pamixer}/bin/pamixer -t";
            on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
            on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
          };
        };
      };
    };
  };
}

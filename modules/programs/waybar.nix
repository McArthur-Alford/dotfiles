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

      # style = ''
      #   @define-color background-darker rgba(30, 31, 41, 230);
      #   @define-color background #282a36;
      #   @define-color background-bright #3c3f52;
      #   @define-color selection #44475a;
      #   @define-color foreground #f8f8f2;
      #   @define-color comment #6272a4;
      #   @define-color cyan #8be9fd;
      #   @define-color green #50fa7b;
      #   @define-color orange #ffb86c;
      #   @define-color pink #ff79c6;
      #   @define-color purple #bd93f9;
      #   @define-color red #ff5555;
      #   @define-color yellow #f1fa8c;
      #   @define-color transparent rgba(20, 31, 41, 0);
      #   * {
      #       border: none;
      #       border-radius: 0;
      #       font-family: Iosevka;
      #       font-size: 11pt;
      #       min-height: 0;
      #   }
      #   window#waybar {
      #       margin-top: 4px;
      #       background: none;
      #       color: @foreground;
      #   }
      #   window > box {
      #     margin-top: 0px;
      #     background: none;
      #   }
      #   .modules-center {
      #     border-radius: 0 0 10 10;
      #     background: @background;
      #   }
      #   #workspaces {
      #     border-radius: 0 0 0 10;
      #     padding-left: 15px;
      #     padding-right: 0px;
      #     margin-right: 5px;
      #     background: @background-bright;
      #   }
      #   #workspaces button {
      #       background: @background-bright;
      #       color: @foreground;
      #       /* border-bottom: 2px solid @foreground;*/
      #   }
      #   #workspaces button:hover {
      #       box-shadow: inherit;
      #       text-shadow: inherit;
      #       background: @green;
      #       color: @background-darker;
      #       /*border-bottom: 2px solid @background-darker;*/
      #   }
      #   #workspaces button.active {
      #       background: @green;
      #       color: @background-darker;
      #       /* border-bottom: 2px solid @background-darker; */
      #   }
      #   #clock {
      #     color: @purple;
      #     padding-right: 8px;
      #     padding-left: 8px;
      #     margin-right: 15px;
      #   }
      #   #pulseaudio {
      #     color: @green;
      #     padding-left: 8px;
      #     margin-left: 8px;
      #   }
      #   #tray {
      #     padding-left: 5px;
      #     margin-left: 8px;
      #   }
      #   #network {
      #     color: @red;
      #     padding-left: 8px;
      #     margin-left: 8px;
      #   }
      #   #cpu {
      #     padding-left: 8px;
      #     margin-left: 8px;
      #   }
      #   #memory {
      #     padding-left: 8px;
      #     margin-left: 8px;
      #     padding-right: 8px;
      #     margin-right: 8px;
      #   }
      # '';

      style = ''
        /* Keyframes */

        @keyframes blink-critical {
        	to {
        		/*color: @white;*/
        		background-color: @critical;
        	}
        }


        /* Styles */

        /* Colors (Dracula) */
        @define-color black    #282a36;  /* Dracula background */
        @define-color red      #ff5555;  /* Dracula red */
        @define-color green    #50fa7b;  /* Dracula green */
        @define-color yellow   #f1fa8c;  /* Dracula yellow */
        @define-color blue     #6272a4;  /* Dracula comment (blue-ish) */
        @define-color purple   #bd93f9;  /* Dracula purple */
        @define-color aqua     #8be9fd;  /* Dracula cyan (aqua-like) */
        @define-color gray     #6272a4;  /* Dracula comment (grayish) */
        @define-color brgray   #44475a;  /* Dracula current line (brighter gray) */
        @define-color brred    #ff5555;  /* Dracula red (bright) */
        @define-color brgreen  #50fa7b;  /* Dracula green (bright) */
        @define-color bryellow #f1fa8c;  /* Dracula yellow (bright) */
        @define-color brblue   #6272a4;  /* Dracula comment (blue tone for bright blue) */
        @define-color brpurple #bd93f9;  /* Dracula purple (bright) */
        @define-color braqua   #8be9fd;  /* Dracula cyan (bright aqua) */
        @define-color white    #f8f8f2;  /* Dracula foreground (white) */
        @define-color bg2      #282a36;  /* Dracula background (for bg2) */

        @define-color warning   @bryellow;
        @define-color critical  @brred;
        @define-color mode      @black;
        @define-color unfocused @bg2;
        @define-color focused   @braqua;
        @define-color inactive  @brpurple;
        @define-color sound     @brpurple;
        @define-color network   @purple;
        @define-color memory    @braqua;
        @define-color cpu       @green;
        @define-color temp      @brgreen;
        @define-color layout    @bryellow;
        @define-color battery   @aqua;
        @define-color date      @black;
        @define-color time	    @white; 

        /* Reset all styles */
        * {
        	border: none;
        	border-radius: 0;
        	min-height: 0;
        	margin: 0;
        	padding: 0;
        	box-shadow: none;
        	text-shadow: none;
        	icon-shadow: none;
        }

        /* The whole bar */
        #waybar {
        	background: @bg2; /* #282828e0 */
        	color: @white;
        	font-family: JetBrains Mono, Siji;
        	font-size: 10pt;
        	/*font-weight: bold;*/
        }

        /* Each module */
        #battery,
        #clock,
        #cpu,
        #language,
        #memory,
        #mode,
        #network,
        #pulseaudio,
        #temperature,
        #tray,
        #backlight,
        #idle_inhibitor,
        #disk,
        #user,
        #mpris {
        	padding-left: 8pt;
        	padding-right: 8pt;
        }

        /* Each critical module */
        #mode,
        #memory.critical,
        #cpu.critical,
        #temperature.critical,
        #battery.critical.discharging {
        	animation-timing-function: linear;
        	animation-iteration-count: infinite;
        	animation-direction: alternate;
        	animation-name: blink-critical;
        	animation-duration: 1s;
        }

        /* Each warning */
        #network.disconnected,
        #memory.warning,
        #cpu.warning,
        #temperature.warning,
        #battery.warning.discharging {
        	color: @warning;
        }

        /* And now modules themselves in their respective order */

        /* Workspaces stuff */
        #workspaces button {
        	/*font-weight: bold;*/
        	padding-left: 2pt;
        	padding-right: 2pt;
        	color: @white;
        	background: @unfocused;
        }

        /* Inactive (on unfocused output) */
        #workspaces button.visible {
        	color: @white;
        	background: @inactive;
        }

        /* Active (on focused output) */
        #workspaces button.focused {
        	color: @black;
        	background: @focused;
        }

        /* Contains an urgent window */
        #workspaces button.urgent {
        	color: @black;
        	background: @warning;
        }

        /* Style when cursor is on the button */
        #workspaces button:hover {
        	background: @black;
        	color: @white;
        }

        #window {
        	margin-right: 35pt;
        	margin-left: 35pt;
          background: transparent;
        }

        #pulseaudio {
        	background: @sound;
        	color: @bg2;
        }

        #network {
        	background: @network;
        	color: @bg2;
        }

        #memory {
        	background: @memory;
        	color: @bg2;
        }

        #cpu {
        	background: @cpu;
        	color: @bg2;
        }

        #temperature {
        	background: @temp;
        	color: @bg2;
        }

        #language {
        	background: @layout;
        	color: @bg2;
        }

        #battery {
        	background: @battery;
        	color: @bg2;
        }

        #tray {
        	background: @date;
        }

        #clock.date {
        	background: @date;
        	color: @white;
        }

        #clock.time {
        	background: @time;
        	color: @bg2;
        }

        #custom-arrow1 {
        	font-size: 11pt;
        	color: @time;
        	background: @date;
        }

        #custom-arrow2 {
        	font-size: 11pt;
        	color: @date;
        	background: @layout;
        }

        #custom-arrow3 {
        	font-size: 11pt;
        	color: @layout;
        	background: @battery;
        }

        #custom-arrow4 {
        	font-size: 11pt;
        	color: @battery;
        	background: @temp;
        }

        #custom-arrow5 {
        	font-size: 11pt;
        	color: @temp;
        	background: @cpu;
        }

        #custom-arrow6 {
        	font-size: 11pt;
        	color: @cpu;
        	background: @memory;
        }

        #custom-arrow7 {
        	font-size: 11pt;
        	color: @memory;
        	background: @network;
        }

        #custom-arrow8 {
        	font-size: 11pt;
        	color: @network;
        	background: @sound;
        }

        #custom-arrow9 {
        	font-size: 11pt;
        	color: @sound;
        	background: transparent;
        }

        #custom-arrow10 {
        	font-size: 11pt;
        	color: transparent;
        	background: transparent;
        }
      '';

      settings = {
     
        Main = {
          layer = "top";
          position = "top";
          modules-left = ["hyprland/workspaces" "custom/arrow10" "hyprland/window" ];
          modules-right = [ "custom/arrow9" "pulseaudio" "custom/arrow8" "network" "custom/arrow7" "memory" "custom/arrow6" "cpu" "custom/arrow5" "temperature" "custom/arrow4" "battery" "custom/arrow3" "custom/arrow2" "tray" "clock#date" "custom/arrow1" "clock#time" ];

          battery = {
            interval = 10;
            states = {
              warning = 30;
              critical = 15;
            };
            format-time = "{H}:{M:02}";
            format = "{icon} {capacity}% ({time})";
            format-charging = " {capacity}% ({time})";
            format-charging-full = " {capacity}%";
            format-full = "{icon} {capacity}%";
            format-alt = "{icon} {power}W";
            format-icons = [ "" "" "" "" "" ];
            tooltip = false;
          };

          "clock#time" = {
            interval = 10;
            format = "{:%H:%M}";
            tooltip = false;
          };

          "clock#date" = {
            interval = 20;
            format = "{:%e %b %Y}";
            tooltip = false;
          };

          cpu = {
            interval = 5;
            tooltip = false;
            format = " {usage}%";
            format-alt = " {load}";
            states = {
              warning = 70;
              critical = 90;
            };
          };

          memory = {
            interval = 5;
            format = " {used:0.1f}G/{total:0.1f}G";
            states = {
              warning = 70;
              critical = 90;
            };
            tooltip = false;
          };

          network = {
            interval = 5;
            format-wifi = " {essid} ({signalStrength}%)";
            format-ethernet = " {ifname}";
            format-disconnected = "No connection";
            format-alt = " {ipaddr}/{cidr}";
            tooltip = false;
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}%";
            format-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" ];
            };
            scroll-step = 1;
            "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            tooltip = false;
          };

          temperature = {
            critical-threshold = 90;
            interval = 5;
            format = "{icon} {temperatureC}°";
            format-icons = [ "" "" "" "" "" ];
            tooltip = false;
          };

          tray = {
            icon-size = 18;
          };

          "hyprland/window" = {
            format = "{}";
            max-length = 30;
            tooltip = false;
          };

          "hyprland/workspaces" = {
        		disable-scroll-wraparound = true;
        		smooth-scrolling-threshold = 4;
        		enable-bar-scroll = true;
        		format = "{name}";
          };

          "custom/arrow1" = { format = ""; tooltip = false; };
          "custom/arrow2" = { format = ""; tooltip = false; };
          "custom/arrow3" = { format = ""; tooltip = false; };
          "custom/arrow4" = { format = ""; tooltip = false; };
          "custom/arrow5" = { format = ""; tooltip = false; };
          "custom/arrow6" = { format = ""; tooltip = false; };
          "custom/arrow7" = { format = ""; tooltip = false; };
          "custom/arrow8" = { format = ""; tooltip = false; };
          "custom/arrow9" = { format = ""; tooltip = false; };
          "custom/arrow10" = { format = ""; tooltip = false; };
        };
      };
    };
  };
}

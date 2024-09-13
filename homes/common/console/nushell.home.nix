{
  config,
  lib,
  pkgs,
  ...
}:
let
  fade =
    {
      fromColor ? "prev_fg",
      toColor ? "prev_bg",
      fadeType ? "between",
    }:
    let
      shades = {
        # ╳
        # l = "░";
        # m = "▒";
        # h = "▓";
        # f = "█";
        l = "🮨";
        m = "🮙";
        h = "╱";
        f = "█";
      };

      formatStep =
        {
          shade,
          fgColor,
          bgColor,
        }:
        "[${shade}](fg:${fgColor} bold bg:${bgColor})";

      fadeBetween = [
        (formatStep {
          shade = shades.l;
          fgColor = toColor;
          bgColor = fromColor;
        })
        (formatStep {
          shade = shades.m;
          fgColor = "prev_fg";
          bgColor = "prev_bg";
        })
        (formatStep {
          shade = shades.m;
          fgColor = "prev_bg";
          bgColor = "prev_fg";
        })
        (formatStep {
          shade = shades.l;
          fgColor = "prev_fg";
          bgColor = "prev_bg";
        })
        (formatStep {
          shade = shades.f;
          fgColor = toColor;
          bgColor = "prev_fg";
        })
      ];

      fadeIn = [
        (formatStep {
          shade = "${shades.l}${shades.m}";
          fgColor = toColor;
          bgColor = fromColor;
        })
      ];

      fadeOut = [
        (formatStep {
          shade = "${shades.m}${shades.l}";
          fgColor = fromColor;
          bgColor = toColor;
        })
      ];

      selectedFade =
        if fadeType == "between" then
          fadeBetween
        else if fadeType == "in" then
          fadeIn
        else if fadeType == "out" then
          fadeOut
        else
          throw "Invalid fade type: ${fadeType}. Use fadeIn, fadeOut, or fadeBetween.";
    in
    lib.concatStringsSep "" selectedFade;
in
{
  imports = [
    ../services/direnv.home.nix
    ./packages.home.nix
  ];
  programs = {
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      configFile.source = ../../../dotfiles/nu/config.nu;
      extraConfig = ''
        use ~/.cache/starship/init.nu
        alias rn = ${pkgs.ranger}/bin/ranger
        cd $env.HOME
      '';
    };

    bash = {
      enable = true;
      bashrcExtra = ''
        eval "\$(starship init bash)"
      '';
    };

    zsh = {
      initExtra = ''
        eval "$(starship init zsh)"
      '';
    };

    direnv.enableNushellIntegration = true;

    starship =
      let
        rhs = fade {
          fromColor = "none";
          toColor = "black";
          fadeType = "in";
        };
        plhs = fade {
          fromColor = "none";
          toColor = "cyan";
          fadeType = "in";
        };
        prhs = fade {
          fromColor = "cyan";
          toColor = "none";
          fadeType = "out";
        };
        into =
          a: b:
          fade {
            fromColor = "${a}";
            toColor = "${b}";
            fadeType = "in";
          };
        out =
          a: b:
          fade {
            fromColor = "${a}";
            toColor = "${b}";
            fadeType = "out";
          };
        between =
          a: b:
          fade {
            fromColor = "${a}";
            toColor = "${b}";
            fadeType = "between";
          };
        solid = a: "[█](fg:${a} bg:prev_bg)";
      in
      {
        enable = true;
        enableNushellIntegration = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableTransience = true;
        settings = {
          add_newline = false;
          scan_timeout = 10;

          palette = "custom";

          format = lib.concatStrings [
            "$username${solid "prev_bg"}$nix_shell${solid "prev_bg"}$directory$git_branch${solid "prev_bg"}$git_status${solid "prev_bg"}${out "prev_bg" "none"}$fill$battery${rhs}\n"
            "${plhs}$shell${prhs}"
          ];

          palettes.custom = {
            none = "0";
            red = "1";
            green = "2";
            yellow = "3";
            purple = "4";
            magenta = "5";
            cyan = "6";
            white = "7";
            comment = "10";
            black = "11";
            orange = "9";
            light_comment = "103";
          };

          nix_shell = {
            disabled = false;
            format = "$state${solid "black"}[$name](fg:white bg:black)";
            impure_msg = "${between "prev_bg" "black"}[impure](bg:black fg:bold red)";
            pure_msg = "${between "prev_bg" "black"}[pure](bg:black fg:bold green)";
            unknown_msg = "${between "prev_bg" "black"}[unknown](bg:black fg:bold orange)";
          };

          line_break = {
            disabled = false;
          };

          fill = {
            symbol = "◢◤";
            style = "fg:comment bg:none";
          };

          character = {
            format = "$symbol";
            success_symbol = "[](fg:green bg:prev_bg)";
            error_symbol = "[](fg:red bg:prev_bg)";
          };

          battery = {
            full_symbol = "";
            format = "[](fg:comment)[ $symbol$percentage ]($style bg:comment)";

            display = [
              {
                threshold = 25;
                style = "bold red";
              }
              {
                threshold = 50;
                style = "bold yellow";
              }
              {
                threshold = 100;
                style = "bold green";
              }
            ];
          };

          time = {
            format = "[\[$time\] ](fg:#fff1cf bg:#6f6565)";
            utc_time_offset = "local";
            time_format = "%T";
            disabled = false;
            time_range = "-";
          };

          git_branch = {
            format = "${between "prev_bg" "black"}[$symbol$branch](fg:white bg:black)";
            symbol = " ";
          };

          shell = {
            format = "$indicator";
            bash_indicator = "[BSH](fg:prev_bg bold bg:prev_fg)";
            nu_indicator = "[NSH](fg:prev_bg bold bg:prev_fg)";
            zsh_indicator = "[ZSH](fg:prev_bg bold bg:prev_fg)";
            disabled = false;
          };

          directory = {
            format = "${between "prev_fg" "cyan"}[$read_only](fg:red bg:prev_bg)[$path](fg:black bg:cyan)";
            style = "fg:0 bg:2";
            truncation_symbol = "…/";
            truncate_to_repo = true;
            truncation_length = 50;
            home_symbol = "";
            read_only = "";
          };

          git_status = {
            format = "[\\[[$all_status$ahead_behind](bg:prev_bg)\\]](bg:prev_bg)";
            conflicted = "🏳";
            ahead = "";
            behind = "";
            diverged = "";
            up_to_date = "✓";
            untracked = "U";
            stashed = "S";
            modified = "M";
            staged = "[++\($count\)](fg:green bg:prev_bg)";
            renamed = "R";
            deleted = "🗑";
          };

          username = {
            format = "${into "prev_bg" "green"}${solid "green"}[ $user](fg:black bg:green)";
            show_always = true;
            disabled = false;
          };
        };
      };
  };
}

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
      style ? "empty",
    }:
    let
      symbols = {
        dot = "•";

        lgt_shd = "░";
        med_shd = "▒";
        hvy_shd = "▓";
        ful_shd = "█";

        lgt_dia = "╱";
        med_dia = "🮨";
        hvy_dia = "🮙";

        btm_rgt_tri = "◢";
        top_lft_tri = "◤";
        out_stripe = "◤◢";
        in_stripe = "◢◤";
      };

      formatStep =
        {
          symbol,
          fgColor,
          bgColor,
        }:
        "[${symbol}](fg:${fgColor} bold bg:${bgColor})";

      # A seperator
      seperator = {
        empty = [ ];
        slash = [
          (formatStep {
            symbol = symbols.top_lft_tri;
            fgColor = fromColor;
            bgColor = "none";
          })
          (formatStep {
            symbol = symbols.in_stripe;
            fgColor = "prev_fg";
            bgColor = "none";
          })
          # (formatStep {
          #   symbol = symbols.lgt_dia;
          #   fgColor = "prev_fg";
          #   bgColor = "none";
          # })
          # (formatStep {
          #   symbol = symbols.med_dia;
          #   fgColor = "prev_fg";
          #   bgColor = "none";
          # })
          (formatStep {
            symbol = symbols.btm_rgt_tri;
            fgColor = toColor;
            bgColor = "none";
          })
          (formatStep {
            symbol = symbols.ful_shd;
            fgColor = toColor;
            bgColor = "prev_fg";
          })
        ];
        thin_slash = [
          (formatStep {
            symbol = symbols.med_dia;
            fgColor = toColor;
            bgColor = fromColor;
          })
          (formatStep {
            symbol = symbols.hvy_dia;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
          (formatStep {
            symbol = symbols.hvy_dia;
            fgColor = "prev_bg";
            bgColor = "prev_fg";
          })
          (formatStep {
            symbol = symbols.med_dia;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
          (formatStep {
            symbol = symbols.ful_shd;
            fgColor = toColor;
            bgColor = "prev_fg";
          })
        ];
        blur = [
          (formatStep {
            symbol = symbols.lgt_shd;
            fgColor = toColor;
            bgColor = fromColor;
          })
          (formatStep {
            symbol = symbols.med_shd;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
          (formatStep {
            symbol = symbols.med_shd;
            fgColor = "prev_bg";
            bgColor = "prev_fg";
          })
          (formatStep {
            symbol = symbols.lgt_shd;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
          (formatStep {
            symbol = symbols.ful_shd;
            fgColor = toColor;
            bgColor = "prev_fg";
          })
        ];
      };

      # Fade from transparent to a color
      fadeIn = {
        empty = [ ];
        slash = [
          (formatStep {
            symbol = symbols.btm_rgt_tri;
            fgColor = toColor;
            bgColor = fromColor;
          })
        ];
        blur = [
          (formatStep {
            symbol = symbols.lgt_shd;
            fgColor = toColor;
            bgColor = fromColor;
          })
          (formatStep {
            symbol = symbols.med_shd;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
          (formatStep {
            symbol = symbols.med_shd;
            fgColor = "prev_bg";
            bgColor = "prev_fg";
          })
          (formatStep {
            symbol = symbols.lgt_shd;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
        ];
      };

      # Fade from a color to transparent
      fadeOut = {
        empty = [ ];
        slash = [
          (formatStep {
            symbol = symbols.top_lft_tri;
            fgColor = fromColor;
            bgColor = toColor;
          })
        ];
        blur = [
          (formatStep {
            symbol = symbols.lgt_shd;
            fgColor = toColor;
            bgColor = fromColor;
          })
          (formatStep {
            symbol = symbols.med_shd;
            fgColor = "prev_bg";
            bgColor = "prev_fg";
          })
          (formatStep {
            symbol = symbols.med_shd;
            fgColor = "prev_bg";
            bgColor = "prev_fg";
          })
          (formatStep {
            symbol = symbols.lgt_shd;
            fgColor = "prev_fg";
            bgColor = "prev_bg";
          })
        ];
      };

      fill = {
        empty = [ ];
        blur = [ symbols.dot ];
        slash = [
          symbols.in_stripe
        ];
      };

      selectedFade =
        if fadeType == "seperator" then
          seperator."${style}"
        else if fadeType == "fadeIn" then
          fadeIn."${style}"
        else if fadeType == "fadeOut" then
          fadeOut."${style}"
        else if fadeType == "fill" then
          fill."${style}"
        else
          throw "Invalid fade type: ${fadeType}.";
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
          fadeType = "fadeIn";
          style = "empty";
        };
        plhs = fade {
          fromColor = "none";
          toColor = "cyan";
          fadeType = "fadeIn";
          style = "slash";
        };
        prhs = fade {
          fromColor = "cyan";
          toColor = "none";
          fadeType = "fadeOut";
          style = "slash";
        };
        into =
          a: b:
          fade {
            fromColor = "${a}";
            toColor = "${b}";
            fadeType = "fadeIn";
            style = "slash";
          };
        out =
          a: b:
          fade {
            fromColor = "${a}";
            toColor = "${b}";
            fadeType = "fadeOut";
            style = "slash";
          };
        seperator =
          a:
          fade {
            fromColor = "prev_fg";
            toColor = "${a}";
            fadeType = "seperator";
            style = "slash";
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
            "$username$nix_shell$directory$git_branch$git_status${out "prev_fg" "none"}$fill$battery${rhs}\n"
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
            format = "${seperator "black"}$state${solid "black"}[$name](fg:white bg:black)${solid "prev_bg"}";
            impure_msg = "[impure](bg:black fg:bold red)";
            pure_msg = "[pure](bg:black fg:bold green)";
            unknown_msg = "[unknown](bg:black fg:bold orange)";
          };

          line_break = {
            disabled = false;
          };

          fill = {
            symbol = fade {
              fadeType = "fill";
              style = "slash";
            };
            style = "fg:red bg:none";
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
            format = "${seperator "black"}[$symbol$branch](fg:white bg:black)${solid "prev_bg"}";
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
            format = "${seperator "cyan"}[$read_only](fg:red bg:prev_bg)[$path](fg:black bg:cyan)${solid "prev_bg"}";
            style = "fg:0 bg:2";
            truncation_symbol = "…/";
            truncate_to_repo = true;
            truncation_length = 50;
            home_symbol = "";
            read_only = "";
          };

          git_status = {
            format = "[\\[[$all_status$ahead_behind](bg:prev_bg)\\]](bg:prev_bg)${solid "prev_bg"}";
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
            format = "${into "prev_bg" "green"}${solid "green"}[ $user](fg:black bg:green)${solid "prev_bg"}";
            show_always = true;
            disabled = false;
          };
        };
      };
  };
}

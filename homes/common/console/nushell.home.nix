{
  config,
  lib,
  pkgs,
  ...
}:
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

    starship = {
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
          "[](bg:black)$character$username$nix_shell$directory$git_branch$git_status[](fg:prev_bg)$fill[$battery](bold bg:6)\n"
          "[ ](bg:black)[$shell](fg:black bg:prev_bg)[](fg:prev_bg bg:white)[](fg:white)\n"
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
          format = "$state[](fg:prev_bg bg:cyan)[(($name))](fg:black bold bg:cyan)[](fg:prev_bg bg:black)";
          impure_msg = "[](fg:prev_bg bg:red)[impure](bg:prev_bg fg:bold black)";
          pure_msg = "[](fg:prev_bg bg:green)[pure](bg:prev_bg fg:bold black)";
          unknown_msg = "[](fg:prev_bg bg:orange)[unknown](bg:prev_bg fg:bold black)";
        };

        line_break = {
          disabled = false;
        };

        fill = {
          symbol = "·";
          style = "fg:comment bg:none";
        };

        character = {
          format = "$symbol";
          success_symbol = "[](fg:green bg:black)[](bg:prev_fg fg:black)[](bg:prev_bg fg:comment)[](bg:prev_fg)";
          error_symbol = "[](fg:red)[](bg:prev_fg fg:black)[](bg:prev_bg fg:comment)[](bg:prev_fg)";
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
          format = "[](fg:prev_bg bg:comment)[$symbol$branch](bg:prev_bg)";
          symbol = "  ";
        };

        shell = {
          bash_indicator = "[](bg:cyan fg:prev_bg)[ BSH](fg:black bold bg:prev_bg)";
          nu_indicator = "[](bg:green fg:prev_bg)[ NSH](fg:black bold bg:prev_bg)";
          zsh_indicator = "[](bg:purple fg:prev_bg)[ ZSH](fg:black bold bg:prev_bg)";
          disabled = false;
        };

        directory = {
          format = "[ ](fg:prev_bg bg:2)[$path]($style)[$read_only ](fg:1 bg:prev_bg)";
          style = "fg:0 bg:2";
          truncation_symbol = "…/";
          truncate_to_repo = false;
          truncation_length = 100;
          home_symbol = " ";
          read_only = " ";
        };

        git_status = {
          format = "[\\[[$all_status$ahead_behind](bg:prev_bg)\\]](bg:prev_bg)";
          conflicted = "🏳";
          ahead = "🏎💨";
          behind = "😰";
          diverged = "😵";
          up_to_date = "✓";
          untracked = "🤷";
          stashed = "📦";
          modified = "📝";
          staged = "[++\($count\)](fg:green bg:prev_bg)";
          renamed = "👅";
          deleted = "🗑";
        };

        username = {
          format = "[](fg:purple bg:prev_fg)[  [$user ](fg:black bg:prev_bg)](fg:black bg:prev_fg)[](fg:prev_bg bg:comment bold)";
          show_always = true;
          disabled = false;
        };
      };

    };
  };
}

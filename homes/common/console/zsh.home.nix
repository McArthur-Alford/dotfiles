{ pkgs, hostname, ... }:
{
  imports = [ ../services/direnv.home.nix ];
  home.packages = with pkgs; [
    xclip
    fd
    ripgrep
    (ripgrep-all.overrideAttrs (_old: {
      doInstallCheck = false;
    }))
    procs
    du-dust
    delta
    kalker
    tldr
    sshs
    rm-improved
    figlet

    meslo-lgs-nf
    dejavu_fonts
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        "FiraCode"
        "DroidSansMono"
      ];
    })
  ];

  fonts.fontconfig.enable = true;

  programs = {
    lazygit = {
      enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
      };
      initExtra = ''
        banner "#bd93f9" "#50fa7b" "$(figlet ${hostname})"
      '';
      plugins = [
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ../../../dotfiles/p10k;
          file = "p10k.zsh";
        }
        {
          name = "zsh-auto-suggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
      ];
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch = {
        enable = true;
      };
      shellAliases = {
        ls = "eza";
        cat = "bat";
        # grep = "rga";
        find = "fd";
        diff = "delta";
        du = "dust";
        calc = "kalker";
        lgit = "lazygit";
      };
    };
    bat = {
      enable = true;
      themes = {
        dracula = builtins.readFile (
          pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "sublime"; # Bat uses sublime syntax for its themes
            rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
            sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
          }
          + "/Dracula.tmTheme"
        );
      };
      config = {
        # theme = "Dracula";
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
    };
    tmux = {
      enable = true;
      tmuxinator.enable = true;
      sensibleOnTop = true;
      plugins = with pkgs.tmuxPlugins; [
        yank
        {
          plugin = dracula;
          extraConfig = ''
                    set -g @dracula-plugins "cpu-usage gpu-usage ram-usage"
                    set -g @dracula-show-powerline true
            				set -g @dracula-refresh-rate 10
                    set -g @dracula-show-left-icon session
          '';
        }
        vim-tmux-navigator
      ];
      keyMode = "vi";
      extraConfig = ''
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        set -g default-terminal "tmux-256color"
        set -ag terminal-overrides ",xterm-256color:RGB"
        set-option -s escape-time 0
      '';
      mouse = true;
    };
  };
}

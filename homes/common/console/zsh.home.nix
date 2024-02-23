{ pkgs, username, ... }:
{
  home.packages = with pkgs; [
    xclip
    fd
    ripgrep
    (ripgrep-all.overrideAttrs (old: {
      doInstallCheck = false;
    }))
    procs
    du-dust
    delta
    kalker
    tldr
    sshs
    rm-improved
  ];

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
      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "dracula/zsh"; tags = [ "as:theme" "depth:1" ]; }
          { name = "plugins/colored-man-pages"; tags = [from:oh-my-zsh]; }
        ];
      };
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch = {
        enable = true;
      };
      shellAliases = {
        ls = "eza";
        cat = "bat";
        grep = "rga";
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
        dracula = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        } + "/Dracula.tmTheme");
      };
      config = {
        theme = "Dracula";
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

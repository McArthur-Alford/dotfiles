{
  pkgs,
  hostname,
  inputs,
  system,
  ...
}:
{
  imports = [
    ../services/direnv.home.nix
    ./packages.home.nix
  ];

  fonts.fontconfig.enable = true;

  programs = {
    zoxide.enableZshIntegration = true;
    fzf.enableZshIntegration = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          src = pkgs.zsh-nix-shell;
          file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
        }
        # {
        #   name = "powerlevel10k";
        #   src = pkgs.zsh-powerlevel10k;
        #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        # }
        # {
        #   name = "powerlevel10k-config";
        #   src = ../../../dotfiles/p10k;
        #   file = "p10k.zsh";
        # }
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
  };
}

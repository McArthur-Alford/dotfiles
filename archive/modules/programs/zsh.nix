{ pkgs, user, ... }:
{
  environment.shells = with pkgs; [ bash zsh ];
  programs.zsh.enable = true;
  users.users.${user}.shell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
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
  ];
}

{ pkgs, user, ... }:
{
  environment.shells = with pkgs; [ bash zsh ];
  programs.zsh.enable = true;
  users.users.${user}.shell = pkgs.zsh;
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
    ripgrep-all
    procs
    du-dust
    delta
    kalker
    tldr
    sshs
    rm-improved
  ];
}
{ pkgs, user, ... }:
{
  environment.shells = with pkgs; [ bash zsh ];
  programs.zsh.enable = true;
  users.users.${user}.shell = pkgs.zsh;
}
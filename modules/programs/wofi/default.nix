{ config, lib, pkgs, host, user, ...}:

{
  environment.systemPackages = with pkgs; [
    wofi
  ];
}

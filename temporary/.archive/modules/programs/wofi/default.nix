{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wofi
  ];
}

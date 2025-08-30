# A nice way to setup cool scripts for myself!
{
  pkgs,
  inputs,
  system,
  systemSettings,
  ...
}:
let
  # switch-all = import ./switch-all.nix { inherit pkgs; };
  # switch-home = import ./switch-home.nix { inherit pkgs; };
  nix-path = systemSettings.nixPath;
  switch = import ./switch.nix { inherit pkgs nix-path; };
  uqvpn = import ./uqvpn.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    # switch-all
    # switch-home
    # pkgs.nh
    switch
    uqvpn
  ];
}

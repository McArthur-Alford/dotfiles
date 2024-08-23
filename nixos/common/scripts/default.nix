# A nice way to setup cool scripts for myself!
{
  pkgs,
  inputs,
  system,
  ...
}:
let
  # switch-all = import ./switch-all.nix { inherit pkgs; };
  # switch-home = import ./switch-home.nix { inherit pkgs; };
  switch = import ./switch.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    # switch-all
    # switch-home
    # pkgs.nh
    switch
  ];
}

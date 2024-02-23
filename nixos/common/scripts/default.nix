# A nice way to setup cool scripts for myself!
{ pkgs,... }:
let
  switch-all = import ./switch-all.nix { inherit pkgs; };
  switch-home = import ./switch-home.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    switch-all
    switch-home
  ];
}

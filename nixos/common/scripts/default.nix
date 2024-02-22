# A nice way to setup cool scripts for myself!
{ pkgs,... }:
# let
  # build-all = import ./build-all.nix { inherit pkgs; };
# in
{
  environment.systemPackages = [
    # build-all
  ];
}

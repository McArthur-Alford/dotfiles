# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs, ... }:
{
  zen = pkgs.callPackage ./zen.nix { };
}

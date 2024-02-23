{ inputs, stateVersion, outputs, nixpkgs, ... }:
let
  helpers = import ./helpers.nix { inherit inputs stateVersion outputs nixpkgs; };
in
{
  inherit (helpers) mkHome mkHost forAllSystems;
}

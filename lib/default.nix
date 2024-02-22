{ inputs, stateVersion, outputs, self, ... }:
let
  helpers = import ./helpers.nix { inherit inputs stateVersion outputs self; };
in
{
  inherit (helpers) mkHome mkHost forAllSystems;
}

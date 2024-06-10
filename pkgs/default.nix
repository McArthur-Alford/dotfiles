# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'

_: {
  # for example:
  # obs-studio = pkgs.callPackage ./obs-studio { };
}

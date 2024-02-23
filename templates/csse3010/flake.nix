{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        openconnectOverlay = import ''${(builtins.fetchTarball {
            url = "https://github.com/vlaci/openconnect-sso/archive/master.tar.gz";
            sha256 = "sha256:08cqd40p9vld1liyl6qrsdrilzc709scyfghfzmmja3m1m7nym94";
          }
        )}/overlay.nix'';
        pkgs = import nixpkgs {
          overlays = [ openconnectOverlay ];
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            openconnect-sso
          ];
        };
      });
}

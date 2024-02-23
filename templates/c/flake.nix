{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        libs = with pkgs; [
          gcc
        ];
        libPath = pkgs.lib.makeLibraryPath libs;
        my-package =
          let
            version = "1.0";
          in
          pkgs.stdenv.mkDerivation {
            name = "program-${version}";

            src = ./.;

            nativeBuildInputs = with pkgs; [ gcc ];
            buildInputs = [ ];

            buildPhase = ''
              gcc main.c -o program
            '';

            installPhase = ''
              mkdir -p $out/bin
              cp program $out/bin
            '';
          };
      in
      {
        packages.default = my-package;

        devShells.default = pkgs.mkShell {
          build-inputs = libs;

          packages = with pkgs; [
            clang-tools
            lldb_17
          ];

          LD_LIBRARY_PATH = libPath;

          shellHook = ''
          '';
        };
      });
}

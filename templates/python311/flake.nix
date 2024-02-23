{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        my-python-packages = ps: with ps; [
          python-lsp-server
          ipython
          # This is how you might build a package from pip!
          # (buildPythonPackage rec {
          #   pname = "plotille";
          #   version = "5.0.0";
          #   src = fetchPypi {
          #     inherit pname version;
          #     sha256 = "sha256-meXKUaLkySLq06OwhjzCxqmks/cBlEWJ3xD0LOAqs9w=";
          #   };
          #   doCheck = false;
          # })
        ];

      in
      rec {
        flakedPkgs = pkgs;

        # enables use of `nix shell`
        devShell = pkgs.mkShell {
          # add things you want in your shell here
          buildInputs = with pkgs; [
            (python311.withPackages my-python-packages)
          ];
        };
      }
    );
}

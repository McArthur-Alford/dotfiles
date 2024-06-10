{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    sourcelib = {
      url = "github:uqembeddedsys/sourcelib";
      flake = false;
    };
  };

  outputs = { nixpkgs, flake-utils, sourcelib, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # overlays = [ openconnectOverlay ];
          config.allowUnfree = true;
          config.segger-jlink.acceptLicense = true; # Make sure you accept this
        };

        customJLink = pkgs.segger-jlink.overrideAttrs (_oldAttrs: rec {
          version = "V794j"; # TODO this doesnt actually work, but does it matter really??? Only time will tell.
        });

        # openconnectOverlay = import ''${(builtins.fetchTarball {
        #     url = "https://github.com/vlaci/openconnect-sso/archive/master.tar.gz";
        #     sha256 = "sha256:08cqd40p9vld1liyl6qrsdrilzc709scyfghfzmmja3m1m7nym94";
        #   }
        # )}/overlay.nix'';
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc-arm-embedded-12
            gdb
            newlib
            screen
            python311Packages.pip
            python311Packages.pylink-square
            customJLink # note: reason for Unfree and Insecure
            clang-tools
            bear
            lldb_17
            # openconnect-sso
          ];

          shellHook = ''
            export SOURCELIB_ROOT="${sourcelib}"
            export PATH="$SOURCELIB_ROOT/tools:$SOURCELIB_ROOT/components/boards/nucleo-f429zi/Inc:$PATH"
          
              echo "Dont forget to run 'sudo usermod -aG dialout $USER', the flake cant do this for you."
          '';
        };
      }
    );
}

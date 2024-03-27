{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, crane, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        craneLib = crane.lib.${system};

        buildDeps = with pkgs; [
          pkg-config
          makeWrapper
          clang
          mold
        ];

        runtimeDeps = with pkgs; [
          libxkbcommon
          # The following deps arent necessary AT ALL, but so many packages depend on them (atleast in the GPU/ML/Gamedev spaces i occupy) that its sensible to just always have them on hand
          alsa-lib
          udev
          vulkan-loader
          wayland
          openssl
        ] ++ (with xorg; [
          libXcursor
          libXrandr
          libXi
          libX11
        ]);

        tomlExists = builtins.isPath (./. + "cargo.toml");
        my-crate = craneLib.buildPackage rec {
          pname = "rust-program";
          src = ./.;

          nativeBuildInputs = buildDeps;
          buildInputs = runtimeDeps;

          postInstall = ''
            wrapProgram $out/bin/${pname} \
              --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath runtimeDeps} \
              --prefix XCURSOR_THEME : "Adwaita"
            mkdir -p $out/bin/assets
            cp -a assets $out/bin
          '';
        };
      in
      {
        checks = if tomlExists then {
          inherit my-crate;
        } else {};

        packages.default = if tomlExists then my-crate else {};

        devShells.default = craneLib.devShell {
          checks = self.checks.${system};

          RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath runtimeDeps}";
          XCURSOR_THEME = "Adwaita";

          packages = with pkgs; [
            rustfmt
            rust-analyzer
            rustPackages.clippy
            rustup
          ] ++ runtimeDeps;
        };
      });
}

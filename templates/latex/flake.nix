{
  description = "Latex Devshell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs }: {
    devShell.x86_64-linux = with nixpkgs.legacyPackages.x86_64-linux;
      mkShell {
        buildInputs = [
          texlive.combined.scheme-full
          texlab
        ];

        shellHook = ''
          echo "Welcome to the magical world of LaTeX!"
        '';
      };
  };
}

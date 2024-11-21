{
  description = "Magical NixOS/Home-Manager Configuration";

  inputs = import ./inputs.nix;

  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "22.11";
      lib = import ./lib {
        inherit
          inputs
          stateVersion
          outputs
          nixpkgs
          ;
      };
      templates = import ./templates { };
    in
    {
      homeConfigurations = {
        "mcarthur@benefactor" = lib.mkHome {
          hostname = "benefactor";
          username = "mcarthur";
          system = "x86_64-linux";
          shell = "alucard";
        };
        "mcarthur@grimoire" = lib.mkHome {
          hostname = "grimoire";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard";
          shell = "alucard";
        };
        "mcarthur@mosaic" = lib.mkHome {
          hostname = "mosaic";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard-niri";
          shell = "alucard";
        };
        "mcarthur@thaumaturge" = lib.mkHome {
          hostname = "thaumaturge";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard-niri";
          shell = "alucard";
        };
      };

      nixosConfigurations = {
        benefactor = lib.mkHost {
          hostname = "benefactor";
          username = "mcarthur";
          system = "x86_64-linux";
        };
        grimoire = lib.mkHost {
          hostname = "grimoire";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard";
        };
        mosaic = lib.mkHost {
          hostname = "mosaic";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard-niri";
        };
        thaumaturge = lib.mkHost {
          hostname = "thaumaturge";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard-niri";
        };
      };

      devShells = lib.forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      formatter = lib.forAllSystems (
        system:
        inputs.nix-formatter-pack.lib.mkFormatter {
          pkgs = nixpkgs.legacyPackages.${system};
          config.tools = {
            alejandra.enable = false;
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        }
      );

      overlays = import ./overlays { inherit inputs; };

      generators = {
        pi4 = lib.mkGenerator {
          name = "pi4";
          system = "aarch64-linux";
          format = "iso";
        };
        pi0 = lib.mkGenerator {
          name = "pi0";
          system = "armv6l-linux";
          format = "iso";
        };
      };

      packages = lib.forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./pkgs { inherit pkgs inputs; }
      );

      inherit templates;
    };
}

{
  description = "Magical NixOS/Home-Manager Configuration";

  inputs = {
    # All flake references used to build NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages
    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-index-database.url = "github:Mic92/nix-index-database";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      inherit (self) outputs;
      stateVersion = "22.11";
      lib = import ./lib { inherit inputs stateVersion outputs nixpkgs; };
      templates = import ./templates { };
    in
    {
      homeConfigurations = {
        # "mcarthur@yggdrasil" = lib.mkHome {
        #   hostname = "yggdrasil";
        #   username = "mcarthur";
        #   system = "x86_64-linux";
        # };
        "mcarthur@grimoire" = lib.mkHome {
          hostname = "grimoire";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop  = "nocturne";
        };
        "mcarthur@thaumaturge" = lib.mkHome {
          hostname = "thaumaturge";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "nocturne";
        };
      };

      nixosConfigurations = {
        # yggdrasil   = lib.mkHost {
        #   hostname = "yggdrasil";
        #   username = "mcarthur";
        #   system = "x86_64-linux";
        # };
        grimoire    = lib.mkHost {
          hostname = "grimoire";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop  = "nocturne";
        };
        thaumaturge = lib.mkHost {
          hostname = "thaumaturge";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "nocturne";
        };
      };

      devShells = lib.forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      formatter = lib.forAllSystems (system:
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

      packages = lib.forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

      inherit templates;
    };
}

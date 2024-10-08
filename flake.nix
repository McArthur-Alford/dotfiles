{
  description = "Magical NixOS/Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # Nix Packages
    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-index-database.url = "github:Mic92/nix-index-database";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprscroller = {
      url = "github:dawsers/hyprscroller";
      inputs.hyprland.follows = "hyprland";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    helix.url = "github:helix-editor/helix/2cadec0";
    ags.url = "github:Aylur/ags";
    base16.url = "github:SenchoPens/base16.nix";
    base16-helix.url = "github:McArthur-Alford/base16-helix";
    base16-helix.flake = false;
    stylix.url = "github:danth/stylix";
    stylix.inputs.base16-helix.follows = "base16-helix";
    sops-nix.url = "github:Mic92/sops-nix";
    peerix = {
      url = "github:cid-chan/peerix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lan-mouse.url = "github:feschber/lan-mouse";
    niri.url = "github:sodiboo/niri-flake";
  };

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
          desktop = "alucard";
          shell = "alucard";
        };
        "mcarthur@thaumaturge" = lib.mkHome {
          hostname = "thaumaturge";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard";
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
          desktop = "alucard";
        };
        thaumaturge = lib.mkHost {
          hostname = "thaumaturge";
          username = "mcarthur";
          system = "x86_64-linux";
          desktop = "alucard";
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

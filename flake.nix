{
  description = "Magical NixOS/Home-Manager Configuration";

  inputs = {							# All flake references used to build NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";	# Nix Packages

    home-manager = {						# Home Package Management
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devtemplates = {
      url = "github:McArthur-Alford/nix-templates";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, 
    nixpkgs, 
    home-manager, 
    hyprland, 
    spicetify-nix,
    devtemplates,
  }:
  let								# Variables that can be used in the config files
    system = "x86_64-linux";					# System Architecture
    user = "mcarthur";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; 				# Allow proprietary software
    };

    lib = nixpkgs.lib;
  in 
  {
    nixosConfigurations = (
      import ./hosts { 						# Imports ./hosts/default.nix, where available configs are located
        inherit (nixpkgs) lib;
        inherit inputs user system home-manager; 		# Inherit home manager so it does not need to be defined here
      	inherit hyprland spicetify-nix;
        inherit nixpkgs;
        inherit devtemplates;
      }
    );
  };
}

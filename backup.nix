# flake.nix
#  ┕━ ./hosts
#      ┕━ default.nix

{
  description = "Magical NixOS/Home-Manager Configuration";

  inputs = {							# All flake references used to build NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";	# Nix Packages
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";	# Unstable Packages
    home-manager = {						# Home Package Management
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland }: # Tells flake which to use and what to do with dependencies
  let								# Variables that can be used in the config files
    system = "x86_64-linux";					# System Architecture
    user = "mcarthur";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true; 				# Allow proprietary software
    };

    lib = nixpkgs.lib;
  in {
    nixosConfigurations = (
      import ./hosts { 						# Imports ./hosts/default.nix, where available configs are located
        inherit (nixpkgs) lib;
        inherit inputs user system home-manager; 		# Inherit home manager so it does not need to be defined here
      }
    );
  };
}

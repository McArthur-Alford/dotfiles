{
  description = "Magical NixOS/Home-Manager Configuration";

  inputs = {							# All flake references used to build NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";	# Nix Packages
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    devtemplates.url = "github:McArthur-Alford/nix-templates";
  };

  outputs = inputs @ { 
    self, 
    nixpkgs, 
    home-manager, 
    hyprland, 
    spicetify-nix,
    devtemplates,
  }:
  let								# Variables that can be used in the config files
    system = "x86_64-linux";					# System Architecture
    user = "mcarthur";

    # pkgs = import nixpkgs {
    #   inherit system;
    #   config.allowUnfree = true; 				# Allow proprietary software
    # };

    lib = nixpkgs.lib;
  in 
  {
    nixosConfigurations = (
      import ./hosts { 						# Imports ./hosts/default.nix, where available configs are located
        inherit nixpkgs lib inputs user system home-manager;
        inherit hyprland spicetify-nix devtemplates;
      }
    );
  };
}

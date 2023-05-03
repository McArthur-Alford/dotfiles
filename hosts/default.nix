{ lib, inputs, system, home-manager, user, hyprland, spicetify-nix, nixpkgs, ... }:
{
  desktop = lib.nixosSystem {						# Desktop Profile
    inherit system;
    specialArgs = { inherit user inputs hyprland spicetify-nix; };
    modules = [
      ./configuration.nix
      ./desktop
      hyprland.nixosModules.default
      home-manager.nixosModules.home-manager {				# Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      	home-manager.extraSpecialArgs = { inherit user spicetify-nix; };	# Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
        };
      }
      {
        environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        nix.nixPath = ["nixpkgs=/etc/nix/inputs/nixpkgs"];
      }
    ];
  };

  # laptop = lib.nixosSystem.... 					# TODO laptop config

  # server = lib.nixosSystem....					# TODO server config
}

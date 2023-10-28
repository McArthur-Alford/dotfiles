{ lib, inputs, system, home-manager, user, nixpkgs, devtemplates, ... }:
{
  desktop = lib.nixosSystem {						# Desktop Profile
    inherit system;
    specialArgs = { inherit user inputs nixpkgs; };
    modules = [
      ./configuration.nix
      ./desktop
      devtemplates.nixosModules.default
      home-manager.nixosModules.home-manager {				# Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      	home-manager.extraSpecialArgs = { inherit user system inputs; };	# Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {						# Laptop Profile
    inherit system;
    specialArgs = { inherit user inputs nixpkgs; };
    modules = [
      ./configuration.nix
      ./laptop
      devtemplates.nixosModules.default
      home-manager.nixosModules.home-manager {				# Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      	home-manager.extraSpecialArgs = { inherit user system inputs; };	# Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [(import ./home.nix)] ++ [(import ./laptop/home.nix)];
        };
      }
    ];
  };

  server = lib.nixosSystem {						# Server Profile
    inherit system;
    specialArgs = { inherit user inputs nixpkgs; };
    modules = [
      ./configuration.nix
      ./server
      devtemplates.nixosModules.default
      home-manager.nixosModules.home-manager {				# Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      	home-manager.extraSpecialArgs = { inherit user system inputs; };		# Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [(import ./home.nix)] ++ [(import ./server/home.nix)];
        };
      }
    ];
  };
}

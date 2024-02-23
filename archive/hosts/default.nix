{ lib, inputs, globals, nixpkgs, ... }:
{
  desktop = lib.nixosSystem {
    # Desktop Profile
    inherit (globals) system;
    specialArgs = { inherit globals inputs nixpkgs; };
    modules = [
      ./configuration.nix
      ./desktop
      inputs.devtemplates.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        # Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user system inputs; }; # Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [ (import ./home.nix) ] ++ [ (import ./desktop/home.nix) ];
        };
      }
    ];
  };

  laptop = lib.nixosSystem {
    # Laptop Profile
    inherit (globals) system;
    specialArgs = { inherit globals inputs nixpkgs; };
    modules = [
      ./configuration.nix
      ./laptop
      inputs.devtemplates.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        # Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user system inputs; }; # Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [ (import ./home.nix) ] ++ [ (import ./laptop/home.nix) ];
        };
      }
    ];
  };

  server = lib.nixosSystem {
    # Server Profile
    inherit (globals) system;
    specialArgs = { inherit globals inputs nixpkgs; };
    modules = [
      ./configuration.nix
      ./server
      inputs.devtemplates.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        # Home Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user system inputs; }; # Pass flake variables
        home-manager.users.${user} = {
          home.stateVersion = "22.11";
          imports = [ (import ./home.nix) ] ++ [ (import ./server/home.nix) ];
        };
      }
    ];
  };
}

{ inputs, stateVersion, outputs, self, ... }: {
  # Helper function for generating home-manager configs
  mkHome = { hostname, username, desktop ? null, system? "x86_64-linux" }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    extraSpecialArgs = {
      inherit inputs outputs desktop hostname system username stateVersion;
    };
    modules = [ (self + "/homes") ];
  };

  # Helper function for generating host configs
  mkHost = { hostname, username, desktop ? null, installer ? null,  system ? "x86_64-linux" }: inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs desktop hostname system username stateVersion;
    };
    modules = [
      (self + "/nixos")
    ] ++ (inputs.nixpkgs.lib.optionals (installer != null) [ installer ]);
  };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}

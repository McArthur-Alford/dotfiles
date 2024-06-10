{ inputs, stateVersion, outputs, nixpkgs, ... }: {
  # Helper function for generating home-manager configs
  mkHome = { hostname, username, desktop ? null, system ? "x86_64-linux" }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    extraSpecialArgs = {
      inherit inputs outputs desktop hostname system username stateVersion;
    };
    modules = [ ../homes ];
  };

  # Helper function for generating host configs
  mkHost = { hostname, username, desktop ? null, installer ? null, system ? "x86_64-linux", kernel ? "latest" }: inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs outputs desktop hostname system username stateVersion nixpkgs kernel;
    };
    modules = [
      ../nixos
    ] ++ (inputs.nixpkgs.lib.optionals (installer != null) [ installer ]);
  };

  mkGenerator = { name, format, system }: inputs.nixos-generators.nixosGenerate {
    specialArgs = {
      inherit inputs outputs name system stateVersion nixpkgs;
    };
    inherit system;
    inherit format;
    modules = [
      ../generators/${name}.nix
    ];
  };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];
}

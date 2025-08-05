# home.nix
{ inputs, systemSettings, ... }:
let
  # VSPkgs = inputs.vintagestory-nix.packages.${systemSettings.system}.net8;
  VSPkgs = inputs.vintagestory-nix.packages.${systemSettings.system}.v1-20-12-net8;
in
{
  imports = [
    inputs.vintagestory-nix.homeManagerModules.default
  ];

  programs.vs-launcher = {
    enable = true;
    gameVersionsDir = ".config/VSLGameVersions";
    installedVersions = [
      # v1-20-12-m
      inputs.vintagestory-nix.packages.${systemSettings.system}.v1-20-12-net8
    ];
  };

  home.packages = [

    inputs.vintagestory-nix.packages.${systemSettings.system}.v1-20-12-net8
  ];
}

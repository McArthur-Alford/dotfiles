# home.nix
{ inputs, systemSettings, ... }:
let
  VSPkgs = inputs.vintagestory-nix.packages.${systemSettings.system}.net8;
in
{
  programs.vs-launcher = {
    enable = true;
    gameVersionsDir = ".config/VSLGameVersions";
    installedVersions = with VSPkgs; [
      v1-20-12-m
    ];
  };

  home.packages = [ VSPkgs.latest ];
}

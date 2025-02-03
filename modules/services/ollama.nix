{ pkgs, systemSettings, ... }:
let
  system = systemSettings.system;
  nixpkgs-pinned = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    # Dubious, came from the issue post:
    # rev = "5df43628fdf08d642be8ba5b3625a6c70731c19c";
    # sha256 = "sha256-Tbk1MZbtV2s5aG+iM99U8FqwxU/YNArMcWAv6clcsBc=";
    #
    # This one works:
    rev = "d0169965cf1ce1cd68e50a63eabff7c8b8959743";
    sha256 = "sha256-BdTeiNTc1DUiEcKhmjjuJ54KRv+8UzyTqRl7QS64AMI=";
    #
    # Alpaca 3.5, slightly newer, still works:
    # rev = "501e3f0dec99ea54c3e2c2e0a8b3041e9c0ca830";
    # sha256 = "sha256-Z54jflalVgi5RJhdOMrz909RyB8sqaKo3/Yq5SRPNP8=";
  };
  pkgs-pinned = import nixpkgs-pinned { inherit system; };
in
{
  # a temporary helpful thing?
  nixpkgs.config.rocmSupport = true;

  services.ollama = {
    enable = true;

    # A necessary pin until this issue is solved:
    # https://github.com/NixOS/nixpkgs/issues/375359
    # RCOM truly is agonizing
    package = pkgs-pinned.ollama-rocm;
    rocmOverrideGfx = "10.3.0";
    loadModels = [
      "deepseek-r1"
    ];
    acceleration = "rocm";
  };

  environment.systemPackages = [
    (pkgs.alpaca.override {
      ollama = pkgs-pinned.ollama-rocm;
    })
    # pkgs.alpaca
  ];
}

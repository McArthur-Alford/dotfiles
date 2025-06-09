{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [ cachix ];

  nix.settings.extra-trusted-public-keys = [ ];
  # nix.settings = {
  #   builders-use-substitutes = true;
  #   extra-substituters = [
  #     "https://anyrun.cachix.org"
  #   ];

  #   extra-trusted-public-keys = [
  #     "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
  #   ];
  # };

  nix.settings = {
    builders-use-substitutes = true;
    substituters = [
      "https://mmwave.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://cache.thaumaturgy.tech"
      "https://nixos-rocm.cachix.org"
      "https://anyrun.cachix.org"
      "https://install.determinate.systems"
    ];
    trusted-public-keys = [
      "mmwave.cachix.org-1:51WVqkk3jgt8S5rmsTZVsFvPw06FpTd1niyrFzJ6ucQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.thaumaturgy.tech:KswERuauGw8ewXdUROeAYYZwPXLBhp7n3pxUBdr+H3A="
      "nixos-rocm.cachix.org-1:VEpsf7pRIijjd8csKjFNBGzkBqOmw8H9PRmgAq14LnE="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
    ];
  };
}

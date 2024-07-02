{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cachix
  ];

  nix.settings = {
    substituters = [
      "https://mmwave.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "mmwave.cachix.org-1:51WVqkk3jgt8S5rmsTZVsFvPw06FpTd1niyrFzJ6ucQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}

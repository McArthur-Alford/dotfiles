{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    cachix
    attic-client
  ];

  nix.settings.extra-trusted-public-keys = [ ];

  sops.secrets.netrc-file = {
    name = "netrc";
    format = "binary";
    sopsFile = ../../../secrets/netrc-file;
  };

  nix.settings = {
    netrc-file = config.sops.secrets.netrc-file.path;
    substituters = [
      "https://mmwave.cachix.org"
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://attic.thaumaturgy.tech/mcarthur"
    ];
    trusted-public-keys = [
      "mmwave.cachix.org-1:51WVqkk3jgt8S5rmsTZVsFvPw06FpTd1niyrFzJ6ucQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "mcarthur:1gfD7pB8Ozu910iBrQHV91bW33yaujeF6dfgJpS38PY="
    ];
  };
}

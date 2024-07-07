{
  pkgs,
  inputs,
  config,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [ sops ];

  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
}

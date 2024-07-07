{
  pkgs,
  inputs,
  config,
  username,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

  sops.secrets.example-key = {
    owner = "${username}";
    key = "example-key";
  };
  sops.secrets."myservice/my_subdir/my_secret" = { };
}

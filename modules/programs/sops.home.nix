{ inputs, userSettings, ... }:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/home/${userSettings.user}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
  };
}

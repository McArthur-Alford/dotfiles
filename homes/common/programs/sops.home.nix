{ inputs, username, ... }:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt"; # must have no password!
    defaultSopsFile = ../../../secrets/secrets.yaml;
    secrets.example-key = {
      path = "%r/example-key.txt";
    };
  };
}

{
  pkgs,
  inputs,
  self,
  ...
}:
{
  environment.systemPackages = with pkgs; [ sops ];

  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/sops/.config/sops/age/keys.txt";
}

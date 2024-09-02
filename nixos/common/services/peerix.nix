{ inputs, config, ... }:
let
  peerix = inputs.peerix;
in
{
  sops.secrets.peerix-public = {
    name = "peerix-public";
    format = "binary";
    sopsFile = ../../../secrets/peerix-public;
  };

  sops.secrets.peerix-private = {
    name = "peerix-private";
    format = "binary";
    sopsFile = ../../../secrets/peerix-private;
  };

  imports = [ peerix.nixosModules.peerix ];
  services.peerix = {
    enable = false;
    package = peerix.packages.x86_64-linux.peerix;
    openFirewall = true;
    privateKeyFile = config.sops.secrets.peerix-private.path;
    publicKeyFile = config.sops.secrets.peerix-public.path;
  };
}

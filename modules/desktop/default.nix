{ self, pkgs, ... }:
{
  imports = [ "${self}/modules/greeter/regreet.nix" ];
}

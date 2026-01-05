{ self, pkgs, ... }:
{
  imports = [ "${self}/modules/greeter/tuigreet.nix" ];
}

{config, desktop, lib, pkgs, username, ...}:
{
  imports = [
    (./. + "/${desktop}.nix")
  ] ++ lib.optional (builtins.pathExists (./. + "/../users/${username}/desktop.nix")) ../users/${username}/desktop.nix;
}

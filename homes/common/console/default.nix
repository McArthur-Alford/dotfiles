{ shell, lib, username, ... }:
{
  imports = [
    (./. + "/${shell}.nix")
  ] ++ lib.optional (builtins.pathExists (./. + "/../users/${username}/shell.nix")) ../users/${username}/shell.nix;
}


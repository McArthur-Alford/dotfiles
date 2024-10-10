{
  shell,
  lib,
  username,
  ...
}:
{
  imports =
    [
      (./. + "/${shell}.home.nix")
    ]
    ++ lib.optional (builtins.pathExists (
      ./. + "/../users/${username}/shell.home.nix"
    )) ../users/${username}/shell.home.nix;
}

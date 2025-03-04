{
  desktop,
  lib,
  username,
  ...
}:
{
  imports =
    [
      (./. + "/${desktop}.home.nix")
    ]
    ++ lib.optional (builtins.pathExists (
      ./. + "/../users/${username}/desktop.nix"
    )) ../users/${username}/desktop.nix;
}

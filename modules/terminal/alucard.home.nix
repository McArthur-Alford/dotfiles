{ self, ... }:
{
  imports = [
    "${self}/modules/terminal/zellij.home.nix"
    "${self}/modules/terminal/zsh.home.nix"
    "${self}/modules/terminal/nushell.home.nix"
    "${self}/modules/terminal/packages.home.nix"
    "${self}/modules/services/direnv.home.nix"
    "${self}/modules/programs/helix.home.nix"
    "${self}/modules/programs/stylix.home.nix"
  ];
}

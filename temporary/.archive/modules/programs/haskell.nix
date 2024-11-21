{ pkgs, ... }:
{
  services.hoogle.enable = true;
  environment.systemPackages = with pkgs; [
    stack
    ghc
    ghcid
    cabal-install
    hlint
    haskell-language-server
  ];
}

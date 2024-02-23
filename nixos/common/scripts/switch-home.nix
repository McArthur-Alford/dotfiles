{ pkgs }:
pkgs.writeScriptBin "switch-home" ''
#!${pkgs.stdenv.shell}

if [ -e /etc/nixos/ ]; then
  ${pkgs.coreutils-full}/bin/true
  pushd /etc/nixos/
  export NIXPKGS_ALLOW_INSECURE=1
  ${pkgs.home-manager}/bin/home-manager switch -b backup --flake /etc/nixos --impure
  popd
else
  ${pkgs.coreutils-full}/bin/echo "ERROR! No nix-config found in /etc/nixos"
fi
''

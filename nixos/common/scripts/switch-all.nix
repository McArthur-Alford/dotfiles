{ pkgs }:
pkgs.writeScriptBin "switch-all" ''
  #!${pkgs.stdenv.shell}

  if [ -e /etc/nixos/ ]; then
    sudo ${pkgs.coreutils-full}/bin/true
    pushd /etc/nixos/
    export NIXPKGS_ALLOW_INSECURE=1
    ${pkgs.home-manager}/bin/home-manager switch -b backup --flake /etc/nixos --impure
    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake .#
    popd
  else
    ${pkgs.coreutils-full}/bin/echo "ERROR! No nix-config found in /etc/nixos"
  fi
''

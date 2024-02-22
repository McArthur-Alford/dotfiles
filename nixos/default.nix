{ config, desktop, hostname, inputs, lib, modulesPath, outputs, pkgs, system, stateVersion, username, ...}: {
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
    ./${hostname}
    ./common/base
    ./common/scripts
    ./common/services/firewall.nix
    ./common/services/openssh.nix
    ./common/users/root
  ]
  ++ lib.optional (builtins.pathExists (./. + "/common/users/${username}")) ./common/users/${username}
  ++ lib.optional (desktop != null) ./common/desktop;

  nixpkgs.hostPlatform = lib.mkDefault system;

  system.stateVersion = stateVersion;
}

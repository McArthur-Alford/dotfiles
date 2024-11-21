{
  desktop,
  shell,
  hostname,
  inputs,
  lib,
  pkgs,
  stateVersion,
  username,
  ...
}:
{
  programs.home-manager.enable = true;

  imports =
    [ inputs.nix-index-database.hmModules.nix-index ]
    ++ lib.optional (builtins.isPath (./. + "common/users/${username}")) ./common/users/${username}
    ++ lib.optional (builtins.isPath (
      ./. + "common/users/${username}/hosts/${hostname}"
    )) ./common/users/${username}/hosts/${hostname}
    ++ lib.optional (desktop != null) ./common/desktop
    ++ lib.optional (shell != null) ./common/console
    ++ [ ./common/default.home.nix ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    inherit stateVersion;
  };

  nixpkgs = {
    overlays = [
      # Add overlays here if necessary
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    package = pkgs.nixVersions.stable;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}

{
  desktop,
  hostname,
  inputs,
  lib,
  username,
  kernel,
  ...
}:
{
  imports =
    [
      inputs.nix-index-database.nixosModules.nix-index
      ./common/base # Core configuration for ALL nixos systems
      ./common/scripts # Useful scripts to have on path
      ./common/services/firewall.nix # firewall configuration
      ./common/services/openssh.nix # openssh configuration
      ./common/programs/sops.nix # SOPS secret management
      ./common/users/root # sudo/root user configuration
      ./common/kernels/${kernel} # kernel selection
      ./${hostname} # host specific configuration
    ]
    ++ lib.optional (builtins.pathExists (
      ./. + "/common/users/${username}"
    )) ./common/users/${username} # user specific configuration that isnt possible using home manager (for example setting default shell)
    ++ lib.optional (desktop != null) ./common/desktop; # desktop specific configuration
}

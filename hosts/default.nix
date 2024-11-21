{
  inputs,
  systemSettings,
  self,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
    "${self}/modules/nix" # Configuration of nix itself!
    # "${self}/modules/base" # Core configuration for ALL nixos systems
    # "${self}/modules/scripts" # Useful scripts to have on path
    # "${self}/modules/services/firewall.nix" # firewall configuration
    # "${self}/modules/services/openssh.nix" # openssh configuration
    "${self}/modules/programs/sops.nix" # SOPS secret management
    # "${self}/modules/users/root" # sudo/root user configuration
    # "${self}/modules/programs/nh.nix" # nix helper
  ];

  environment = {
    systemPackages = with pkgs; [
      git
      # inputs.helix.packages.${system}.default
      helix
      helix-gpt
      nil
      wget
      curl
    ];
    variables = {
      SYSTEMD_EDITOR = "hx";
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };

  networking = {
    hostName = systemSettings.hostname;
  };
}

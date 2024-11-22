{
  userSettings,
  systemSettings,
  inputs,
  self,
  ...
}:
{
  programs.home-manager.enable = true;

  imports = [
    inputs.nix-index-database.hmModules.nix-index
    "${self}/modules/programs/sops.home.nix"
    "${self}/modules/services/ssh.home.nix"
  ];

  home.username = "${userSettings.user}";
  home.homeDirectory = "/home/${userSettings.user}";
  home.stateVersion = systemSettings.stateVersion;
}

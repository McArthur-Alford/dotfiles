{ username, pkgs, ... }:
{
  programs.zsh.enable = true;
  users.users.${username} = {
    shell = pkgs.nushell; # cannot be set in home manager! very sad
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "libvirtd"
      "wheel"
      "audio"
      "corectrl"
      "daemon"
    ];
  };
  nix.settings.trusted-users = [
    "root"
    username
  ];
}

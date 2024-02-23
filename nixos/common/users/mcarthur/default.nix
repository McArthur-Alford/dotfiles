{username, pkgs, ...}:
{
  programs.zsh.enable = true;
  users.users.${username} = {
    shell = pkgs.zsh; # cannot be set in home manager! very sad
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" "audio" "corectrl" ];
  };
}

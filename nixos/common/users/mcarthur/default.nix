{username, ...}:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" "audio" "corectrl" ];
  };
}

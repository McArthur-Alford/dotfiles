{ pkgs, ... }:
{
  users.groups.usb = { };
  users.users."mcarthur" = {
    shell = pkgs.nushell; # cannot be set in home manager! very sad
    isNormalUser = true;
    description = "mcarthur";
    extraGroups = [
      "networkmanager"
      "libvirtd"
      "wheel"
      "audio"
      "corectrl"
      "daemon"
      "usb"
    ];
  };

}

{ pkgs, ... }:
{
  users.groups.usb = { };
  users.users."mcarthur" = {
    shell = pkgs.nushell; # cannot be set in home manager! very sad
    isNormalUser = true;
    description = "mcarthur";
    hashedPassword = "$y$j9T$UdB1XvpbUhh1svbuj.x/9.$KWanlI29j5CqnfOAbdtDNAD0pGAuS174UH/tmJIMcc4";
    extraGroups = [
      "networkmanager"
      "libvirtd"
      "wheel"
      "audio"
      "corectrl"
      "daemon"
      "usb"
      "docker"
      "gamemode"
      "render"
      "video"
    ];
  };
}

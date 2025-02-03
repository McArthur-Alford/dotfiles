{
  hostname = "mosaic";
  system = "x86_64-linux";
  kernel = "latest";
  users = [ "mcarthur" ];
  stateVersion = "22.11";
  trustedUsers = [ "mcarthur" ];
  nixPath = "/etc/nixos";
  misc = { };
}

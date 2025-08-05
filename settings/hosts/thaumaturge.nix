{
  hostname = "thaumaturge";
  system = "x86_64-linux";
  kernel = "latest";
  users = [ "mcarthur" ];
  stateVersion = "22.11";
  trustedUsers = [ "mcarthur" ];
  nixPath = "/etc/nixos";
  misc = {
    primaryMonitor = {
      width = 5120;
      height = 1440;
      steamWidth = 2560;
      refreshRate = 240;
      vrr = false;
      hdr = false;
    };
  };
}

{ pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud26;
    hostName = "magic";
    config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
  };

}

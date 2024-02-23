{ config, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;
}


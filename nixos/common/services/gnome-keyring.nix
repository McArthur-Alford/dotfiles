_: {
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}

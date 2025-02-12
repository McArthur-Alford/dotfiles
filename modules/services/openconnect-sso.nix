{
  pkgs,
  inputs,
  systemSettings,
  ...
}:
{
  environment.systemPackages = [
    pkgs.openconnect_openssl
    pkgs.networkmanager
    pkgs.networkmanager-openconnect
    pkgs.globalprotect-openconnect
    inputs.openconnect-sso.packages.${systemSettings.system}.default
  ];
}

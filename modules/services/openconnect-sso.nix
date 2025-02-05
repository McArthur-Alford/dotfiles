{
  pkgs,
  inputs,
  systemSettings,
  ...
}:
{
  environment.systemPackages = [
    pkgs.openconnect_openssl
    inputs.openconnect-sso.packages.${systemSettings.system}.default
  ];
  # jKxbueG7fW5DFs
}

{ config, lib, pkgs, host, user, ...}:
{
  environment.systemPackages = with pkgs; [
    python39
    poetry
  ];

  home-manager.users.${user} = {

  };
}

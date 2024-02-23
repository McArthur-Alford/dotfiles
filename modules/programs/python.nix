{ pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    python39
    poetry
    glibc
    python39Packages.tkinter
    tk
  ];

  home-manager.users.${user} = { };
}

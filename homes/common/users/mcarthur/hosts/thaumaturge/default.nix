{ pkgs, ... }:
{
  imports = [
    ../../../../services/virtualisation.home.nix
  ];

  home.packages = with pkgs; [
    # Fan control stuff
    lm_sensors
    liquidctl

    ani-cli

    # Keyboard management for charybdis
    via
    vial
    qmk
    # qmk_hid
    qmk-udev-rules

    # gaming stuff
    lutris
    protonup-ng

    # minecraft
    prismlauncher
  ];
}

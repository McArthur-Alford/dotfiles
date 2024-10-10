{
  pkgs,
  lib,
  config,
  inputs,
  system,
  username,
  ...
}:
{
  environment = {
    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    etc."greetd/environments".text = ''
      Hyprland
    '';
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  services = {
    fprintd.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          # for cage:
          # command = "
          #   dbus-run-session ${pkgs.cage}/bin/cage -s -- ${lib.getExe config.programs.regreet.package}
          # ";
          command = "dbus-run-session ${inputs.hyprland.packages.${system}.default}/bin/Hyprland";
          user = "${username}";
        };
        default_session = initial_session;
      };
    };
  };

  programs = {
    # regreet = {
    #   enable = true;
    # };
    hyprland = {
      package = inputs.hyprland.packages.${system}.default;
      enable = true;
    };
  };
}

{ config, lib, pkgs, system, hyprland, ...}:
{
  # imports = [ ../../programs/waybar.nix ];
  environment = {
    variables = {
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
    systemPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      grim
      mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
      hyprpaper
      qt6.full
      xwayland
    ];
  };

  services = {

    blueman.enable = true;
    xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      desktopManager.xterm.enable = false;
      excludePackages = [ pkgs.xterm ];

      displayManager.defaultSession = "hyprland";
    };
  };

  programs = {
    hyprland = {
      enable = true;
    };
    xwayland.enable = true;
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     waybar = hyprland.packages.${system}.waybar-hyprland;
  #   })
  # ];
}






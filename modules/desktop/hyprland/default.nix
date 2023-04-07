{ config, lib, pkgs, host, system, hyprland, ...}:
{
  imports = [ ../../programs/waybar.nix ];
  environment = {
    variables = {
      XDG_CURRENT_DESKTOP="Hyprland";
      XDG_SESSION_TYPE="wayland";
      XDG_SESSION_DESKTOP="Hyprland";
    };
    sessionVariables = with host; {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
    ];
  };

  programs = {
    hyprland = {
      enable = true;
    };
    waybar = {
      enable = true;
    };
  };

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     waybar = hyprland.packages.${system}.waybar-hyprland;
  #   })
  # ];
}






{ pkgs, ... }:
{
  programs.xwayland.enable = true;

  environment = {
    variables = {
      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
    };
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      mpvpaper
      swappy
      wl-clipboard
      wlr-randr
      swww
      qt6.full
      xwayland
      xdg-utils
    ];
  };

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      # xdg-desktop-portal-hyprland
    ];
  };
}

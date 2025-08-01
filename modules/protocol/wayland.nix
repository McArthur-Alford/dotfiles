{ pkgs, ... }:
{
  programs.xwayland.enable = true;

  environment = {
    variables = {
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "sway";
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
      xdg-desktop-portal
    ];
  };

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "gnome;gtk;wlr;";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      # xdg-desktop-portal-hyprland
    ];
  };
}

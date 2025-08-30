{
  self,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    "${self}/modules/protocol/wayland.nix"
  ];

  services.xserver.displayManager.session = [
    {
      manage = "desktop";
      name = "niri-session";
      start = ''
        ${pkgs.niri}/bin/niri-session &
        waitPID=$!
      '';
    }
  ];
}

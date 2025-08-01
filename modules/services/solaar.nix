{ pkgs, inputs, ... }:
{
  imports = [
    inputs.solaar.nixosModules.default
  ];
  services.udev.packages = [
    pkgs.logitech-udev-rules
  ];
  hardware.logitech.wireless.enable = true;
  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window = "hide";
    batteryIcons = "regular";
    extraArgs = "";
  };
}

{pkgs, ...}: 
# Instructions from https://forum.manjaro.org/t/samsung-odyssey-g9-cant-drive-5120x1440-at-240-hz/59424/6
# Reference from the NixOS Hardware repo https://github.com/NixOS/nixos-hardware/blob/master/lenovo/legion/16ach6h/edid/default.nix
let
  g9-oled-edid = pkgs.runCommandNoCC "g9-oled-edid" { } ''
    mkdir -p $out/lib/firmware/edid
    cp ${./edid.bin} $out/lib/firmware/edid/g9-oled-edid.bin
  '';
in
{
  # The kernel patch is from https://gitlab.freedesktop.org/drm/amd/-/issues/1442#note_2100617
  boot.kernelPatches = [
    {
      name = "";
      patch = ./0001-drm-edid-Add-EDID-quirk-for-a-240Hz-Samsung-monitor.patch;
    }
  ];

  hardware.firmware = [ g9-oled-edid ];

  # Todo: Replace explicit DP-3 with a parameter?
  boot.kernelParams = [ "drm.edid_firmware=DP-3:edid/g9-oled-edid.bin" ];
}

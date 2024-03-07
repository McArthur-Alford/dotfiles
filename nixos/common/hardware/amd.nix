{ pkgs, ... }:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ]; # Video Drivers
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl.enable = true;

  hardware.opengl.driSupport = true;
}

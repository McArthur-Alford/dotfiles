{ config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  virtualisation.docker.enableNvidia = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.modesetting.enable = true;
}

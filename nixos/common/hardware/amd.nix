_:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ]; # Video Drivers
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics.enable = true;
}

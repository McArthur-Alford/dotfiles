_: {
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics.enable = true;
}

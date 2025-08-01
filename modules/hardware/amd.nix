{ pkgs, ... }:
{
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [ rocmPackages.rocm-smi ];

  hardware.graphics.enable = true;
}

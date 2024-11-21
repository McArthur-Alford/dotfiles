{ pkgs, config, intelBusId, nvidiaBusId, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  environment.systemPackages = [ nvidia-offload ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    package = config.boot.kernelPackages.nvidiaPackages.beta;

    open = false;

    nvidiaSettings = true;

    modesetting.enable = true;
    prime = {
      #  offload = {
      #    enable = true;
      # enableOffloadCmd = true;
      #  };

      # sync.enable = true;

      reverseSync.enable = true;

      inherit intelBusId nvidiaBusId;
    };
  };

  environment.sessionVariables = rec {
    INTEL_BUS_ID = intelBusId;
    NVIDIA_BUS_ID = nvidiaBusId;
  };
}

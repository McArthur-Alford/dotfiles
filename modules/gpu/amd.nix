{pkgs, ...}:
{
  boot = {
    initrd.kernelModules = ["amdgpu"];					# Video Drivers
  };

  services.xserver.videoDrivers = ["amdgpu"];

  # --- AMD GPU ---
  nixpkgs.config.rocmTargets = [ "gfx1030" ];
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
    vulkan-tools
    miopengemm
    rocm-cmake
    llvmPackages_rocm.llvm
    llvmPackages_rocm.clang
    llvmPackages_rocm.rocmClangStdenv
  ];
  hardware.opengl.driSupport = true;

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];
}

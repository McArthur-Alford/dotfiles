{ config, lib, pkgs, host, user, ...}:
{
  environment.systemPackages = with pkgs; [
    python39
    rocm-smi
    radeontop
    poetry
  ];

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.rocm-opencl-icd ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];

  home-manager.users.${user} = {

  };
}

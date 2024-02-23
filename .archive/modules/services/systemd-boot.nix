_:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5; # Limit amount of configurations
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      timeout = 5; # Grub auto select time
    };
  };
}

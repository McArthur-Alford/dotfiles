_: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10; # Limit amount of configurations
        # extraInstallCommands = ''
        #   echo "console-mode=3" >> /boot/efi/loader/loader.conf
        # '';
      };
      efi.canTouchEfiVariables = true;
      timeout = 5; # Grub auto select time
    };
  };
}

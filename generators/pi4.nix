{ config, pkgs, lib, ... }:
let
  user = "mmwave";
  password = "mmwave";
  hostname = "mmwave";
  overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];
in {
  nixpkgs.overlays = overlays;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = hostname;
  };

  environment.systemPackages = with pkgs; [ helix ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "yes";
      X11Forwarding = true;
    };
  };
  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      password = password;
      extraGroups = [ "wheel" ];
    };
  };

  hardware.enableRedistributableFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}

# { nixpkgs, inputs, ... }:
# let 
#   pkgs = import nixpkgs;
# in
# {
#    # ----------- HARDWARE: -------------
#   imports = [
#     inputs.nixos-hardware.nixosModules.raspberry-pi-4
#   ];
#   environment.systemPackages = with pkgs; [
#     libraspberrypi
#     raspberrypi-eeprom
#   ];

#   # # ------------- BOOT: --------------
#   # boot= {
#   #   kernelPackages = pkgs.linuxPackages_rpi4;
#   #   loader = {
#   #     grub.enable = false;
#   #     raspberryPi = {
#   #       enable = true;
#   #       version = 4;
#   #     };
#   #   };
#   # };

#   # # -------------- USER: -------------
#   # users.users.mmwave = {
#   #   isNormalUser = true;
#   #   password = "mmwave";
#   # };

#   # ---------- SSH: -------------
#   services.openssh = {
#     enable = true;
#     settings = {
#       PasswordAuthentication = true;
#       KbdInteractiveAuthentication = true;
#       PermitRootLogin = "yes";
#       X11Forwarding = true;
#     };
#   };
#   programs.ssh.startAgent = true;
#   networking.firewall.allowedTCPPorts = [ 22 ];

#   # ----------- STATEVERSION: ----------
#   system.stateVersion = "23.11";
# }

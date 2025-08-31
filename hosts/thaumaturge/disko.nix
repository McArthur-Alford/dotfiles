{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-nvme.1987-3231323337393038303030313330333734323730-436f7273616972204d5036303020434f5245-00000001";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  # Subvolume name is the same as the mountpoint
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
                  "/home/mcarthur" = { };
                  "/home/sops" = { };
                  # Parent is not mounted so the mountpoint must be set
                  "/nix" = {
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                    mountpoint = "/nix";
                  };
                  # This subvolume will be created but not mounted
                  "/test" = { };
                  # Subvolume for the swapfile
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "32G";
                    };
                  };
                };

                # swap = {
                #   swapfile = {
                #     size = "32G";
                #   };
                # };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-id/nvme-Corsair_MP600_CORE_2104790700013036587B_1-part1";
    fsType = "ext4";
  };

  fileSystems."/mnt/storage2" = {
    device = "/dev/disk/by-id/nvme-nvme.1987-3231303638323939303030313239313934314246-466f726365204d50353130-00000001";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/.swapvol";
      size = 32 * 1024;
    }
  ];

}

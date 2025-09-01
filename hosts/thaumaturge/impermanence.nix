{ inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/root"
      "/etc/nixos"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
    users.mcarthur = {
      directories = [
        "Downloads"
        "Development"
        "Videos"
        {
          directory = ".ssh";
        }
        {
          directory = ".config";
        }
        {
          directory = ".cache";
        }
        {
          directory = ".local/share/keyrings";
        }
        ".local/share/direnv"
      ];
      files = [
      ];
    };
  };

  # fileSystems."/persistent".neededForBoot = true;
  # fileSystems."/nix".neededForBoot = true;

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir -p /btrfs_tmp
    mount -t btrfs -o subvolid=5 /dev/disk/by-uuid/aebb0614-e6d9-49a1-a398-86059cd7b8f6 /btrfs_tmp

    if [[ -e /btrfs_tmp/rootfs ]]; then
      mkdir -p /btrfs_tmp/old_roots
      timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/rootfs)" "+%Y-%m-%-d_%H:%M:%S")
      mv /btrfs_tmp/rootfs "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume_recursively "/btrfs_tmp/$i"
      done
      btrfs subvolume delete "$1"
    }

    # prune old snapshots (>30 days)
    if [[ -d /btrfs_tmp/old_roots ]]; then
      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mindepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
      done
    fi

    # recreate the active rootfs
    btrfs subvolume create /btrfs_tmp/rootfs
    umount /btrfs_tmp
  '';

}

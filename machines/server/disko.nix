{config, ...}: {
  disko = {
    devices = {
      disk.system = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-KINGSTON_RBUSNS8154P3256GJ1_50026B76838DDF76";

        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";

                settings = {
                  allowDiscards = true; # good for NVMe
                };

                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };

      disk.hdd1 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000cca250d493a1";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zp0";
            };
          };
        };
      };

      disk.hdd2 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000cca23dcd69cf";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zp0";
            };
          };
        };
      };

      disk.hdd3 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000cca22bf167a9";
        content = {
          type = "gpt";
          partitions.zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zp0";
            };
          };
        };
      };

      zpool.zp0 = {
        type = "zpool";

        mode = {
          topology = {
            type = "topology";
            vdev = [
              {
                mode = "raidz1";
                members = ["hdd1" "hdd2" "hdd3"];
              }
            ];
          };
        };

        rootFsOptions = {
          compression = "zstd";
          atime = "off";
        };

        mountpoint = "/zp0";

        datasets = {
          media = {
            type = "zfs_fs";
            options = {
              mountpoint = "/zp0/media";
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              keylocation = "file:///run/secrets/zfs_media_key";
            };
          };
        };
      };
    };
    zfs.enable = true;
  };
}

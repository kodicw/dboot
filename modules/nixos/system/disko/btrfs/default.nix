{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.disko.btrfs;
in
{
  options.${namespace}.system.disko.btrfs = with types;
    {
      enable = mkEnableOption "Whether or not to enable";
      device = mkOption {
        type = types.str;
        default = "/dev/sda";
      };
    };
  config =
    mkIf cfg.enable {
      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = cfg.device;
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  priority = 1;
                  name = "ESP";
                  start = "1M";
                  end = "128M";
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
                      # Parent is not mounted so the mountpoint must be set
                      "/nix" = {
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                        mountpoint = "/nix";
                      };
                      # Subvolume for the swapfile
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap = {
                          swapfile.size = "20M";
                          swapfile2.size = "20M";
                          swapfile2.path = "rel-path";
                        };
                      };
                    };

                    mountpoint = "/partition-root";
                    swap = {
                      swapfile = {
                        size = "20M";
                      };
                      swapfile1 = {
                        size = "20M";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}

{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.disko.gpt_bios;
in
{
  options.${namespace}.system.disko.gpt_bios = with types;
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
            device = cfg.device;
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                boot = {
                  size = "1M";
                  type = "EF02"; # for grub MBR
                };
                root = {
                  size = "100%";
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
      };
    };

}

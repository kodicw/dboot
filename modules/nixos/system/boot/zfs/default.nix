{ config
, lib
, pkgs
, namespace
, options
, ...
}:
let
  cfg = config.${namespace}.system.boot.zfs;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.system.boot.zfs = {
      enable = mkEnableOption "Enable zfs support";
      hostId = mkOption {
        type = types.str;
        default = "39fa3bef";
        description = "The device to on";
      };
    };
  };
  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "zfs" ];
    boot.zfs.forceImportRoot = false;
    networking.hostId = cfg.hostId;
  };
}


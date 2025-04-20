{ lib, config, namespace, ... }:
let
  cfg = config.${namespace}.system.shareclient;
in
with lib;
{


  options = {
    ${namespace}.system.shareclient = {
      enable = mkEnableOption "Enable share";
      device = mkOption {
        type = types.str;
        default = "192.168.1.16:/share";
        description = "NFS share device";
        example = "293.168.1.16:/share";
      };
    };
  };
  config = mkIf cfg.enable {
    fileSystems."/mnt/share" = {
      device = cfg.device;
      fsType = "nfs";
      options = [ "x-systemd.automount" "x-systemd.idle-timeout=600" "noauto" ];
    };
    networking.firewall.allowedTCPPorts = [ 2049 ];
  };
}



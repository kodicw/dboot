{ lib, config, namespace, ... }:
let
  cfg = config.${namespace}.system.share;
in
with lib;
{


  options = {
    ${namespace}.system.share = {
      enable = mkEnableOption "Enable share server";
      device = mkOption {
        type = types.str;
        default = "/mnt/wdhdd";
        description = "Device to be shared";
      };
      exports = mkOption {
        type = types.str;
        default = ''
          /export        192.168.1.0/24(rw,fsid=0,no_subtree_check) 
          /export/share  192.168.1.0/24(rw,nohide,insecure,no_subtree_check)
        '';
      };
    };
  };
  config = mkIf cfg.enable {

    fileSystems."/export/share" = {
      device = cfg.device;
      # options = [ "bind" "rw" "user" "nofail" "exec" "async" "auto" "dev" "suid" ];
      options = [ "bind" "x-systemd.automount" "x-systemd.idle-timeout=600" "noauto" ];
    };

    services.nfs.server.enable = true;
    services.nfs.server.exports = cfg.exports;
    networking.firewall.allowedTCPPorts = [ 2049 ];
  };
}

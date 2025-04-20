{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.ceph;
in
{
  options.${namespace}.services.ceph = with types;
    {
      enable = mkEnableOption "Whether or not to configure ceph";
    };
  config = mkIf cfg.enable {
    services.ceph = {
      global = {
        monHost = "rpi4";
        clusterName = "ceph";
        fsid = "a0b4c4e6-8c2f-4a7b-8e4b-2e3e2b6b4e4b";
      };
      enable = true;
      mon = {
        enable = true;
      };
    };
  };
}

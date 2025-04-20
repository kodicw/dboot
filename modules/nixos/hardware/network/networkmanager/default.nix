{ config
, pkgs
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.hardware.networkmanager;
in
{
  options = {
    ${namespace}.hardware.networkmanager.enable = lib.mkEnableOption "Enable networkmanager";
  };
  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}


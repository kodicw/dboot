{ config
, pkgs
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.hardware.bluetooth;
in
{
  options = {
    ${namespace}.hardware.bluetooth.enable = lib.mkEnableOption "Enable bluetooth";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluez
      blueman
    ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}


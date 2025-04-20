{ pkgs, namespace, config, lib, ... }:
let
  cfg = config.${namespace}.hardware.network.container-net;
in
{
  options.${namespace}.hardware.network.container-net = with lib; {
    enable = mkEnableOption "Enable container networking";
    interfaces = with types; mkOption {
      type = listOf str;
      default = [ ];
      description = "List of interfaces to be used for container networking";
    };
    containerInterfaces = with types; mkOption {
      type = listOf str;
      default = [ ];
      description = "List of interfaces to be used for container networking";
    };
    staticIP = with types; mkOption {
      type = str;
      default = " ";
      description = "Static IP address for the container network";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.network = {
      enable = true;
      wait-online.enable = lib.mkForce false;
    };
    networking = {
      nat = {
        enable = true;
        internalInterfaces = cfg.containerInterfaces;
        externalInterface = "br0";
      };
      useNetworkd = true;
      # When using systemd-networkd useDHCP must be set to false
      useDHCP = false;
      bridges = {
        br0 = {
          interfaces = cfg.interfaces;
        };
      };
      interfaces = {
        br0 = {
          useDHCP = true;
          ipv4.addresses = [{ address = cfg.staticIP; prefixLength = 24; }];
        };
      };
    };
  };
}

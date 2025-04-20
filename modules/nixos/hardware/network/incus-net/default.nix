{ pkgs, namespace, config, lib, ... }:
let
  cfg = config.${namespace}.hardware.network.incus-net;
  bridge-interface = "incusbr0";
  openPorts = [ 8443 ];
in
{
  options.${namespace}.hardware.network.incus-net = with lib; {
    enable = mkEnableOption "Enable container networking";
    bridgedInterfaces = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "List of interfaces to be used for container networking";
    };
  };
  config = lib.mkIf cfg.enable {
    networking = {
      nftables.enable = true;
      firewall = {
        interfaces."${bridge-interface}" = {
          allowedTCPPorts = [ 53 67 ];
          allowedUDPPorts = [ 53 67 ];
        };
        enable = true;
        allowedTCPPorts = openPorts;
        trustedInterfaces = [
          bridge-interface
        ];
      };
    };
  };
}

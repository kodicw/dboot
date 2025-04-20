{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.tailscale;
in
{
  options.${namespace}.services.tailscale = with types; {
    enable = mkEnableOption "Whether or not to configure Tailscale";
    tempAuthKey = mkEnableOption "Whether or not to use a temporary auth key";
    upFlags = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    useRoutingFeatures = mkOption {
      type = types.str;
      default = "none";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ tailscale ];
    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.tailscaleAuthKey = mkIf cfg.tempAuthKey { };
    };
    services.tailscale = {
      enable = true;
      authKeyFile = mkIf cfg.tempAuthKey "/run/secrets/tailscaleAuthKey";
      extraUpFlags = cfg.upFlags;
      useRoutingFeatures = cfg.useRoutingFeatures;
    };
    networking = {
      firewall = {
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
        allowedUDPPorts = [ config.services.tailscale.port ];
        # Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups.
        checkReversePath = "loose";
      };
      networkmanager.unmanaged = [ "tailscale0" ];
    };
  };
}

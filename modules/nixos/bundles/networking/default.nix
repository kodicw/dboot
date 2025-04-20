{ pkgs
, config
, options
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.networking;
  tools = {
    lldpd = enabled;
    netscanner = enabled;
  };
  services = {
    mullvad-vpn = enabled;
  };
in
{
  options.${namespace}.bundles.networking.enable = mkEnableOption "common";
  config = mkIf cfg.enable {
    genix = { inherit tools services; };
  };
}

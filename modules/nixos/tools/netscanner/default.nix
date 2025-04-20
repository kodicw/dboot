{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.netscanner;
in
{
  options.${namespace}.tools.netscanner = with types;
    {
      enable = mkEnableOption "Whether or not to enable netscanner.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ netscanner ]; };
}

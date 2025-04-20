{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.netdiscover;
in
{
  options.${namespace}.cli-apps.netdiscover = with types;
    {
      enable = mkEnableOption "Whether or not to enable netdiscover.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ netdiscover ]; };
}

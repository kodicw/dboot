{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.lldpd;
in
{
  options.${namespace}.tools.lldpd = with types;
    {
      enable = mkEnableOption "Whether or not to enable lldpd.";
    };

  config =
    mkIf cfg.enable {
      environment.systemPackages = [ pkgs.lldpd ];

    };
}

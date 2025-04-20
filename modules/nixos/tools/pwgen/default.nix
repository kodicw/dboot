{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.pwgen;
in
{
  options.${namespace}.tools.pwgen = with types;
    {
      enable = mkEnableOption "Whether or not to enable pwgen.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ pwgen ]; };
}

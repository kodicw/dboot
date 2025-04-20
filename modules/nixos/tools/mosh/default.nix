{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.mosh;
in
{
  options.${namespace}.tools.mosh = with types;
    {
      enable = mkEnableOption "Whether or not to enable mosh.";
    };

  config =
    mkIf cfg.enable {
      programs.mosh = {
        enable = true;
        openFirewall = true;
      };
    };
}

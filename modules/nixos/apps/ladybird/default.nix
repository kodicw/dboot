{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.ladybird;
in
{
  options.${namespace}.apps.ladybird = with types;
    {
      enable = mkEnableOption "Whether or not to enable ladybird.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ ladybird ]; };
}

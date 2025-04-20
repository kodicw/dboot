{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.fastfetch;
in
{
  options.${namespace}.cli-apps.fastfetch = with types;
    {
      enable = mkEnableOption "Whether or not to enable fastfetch.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ fastfetch ]; };
}

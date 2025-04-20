{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.wget;
in
{
  options.${namespace}.cli-apps.wget = with types;
    {
      enable = mkEnableOption "Whether or not to enable wget.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ wget ]; };
}

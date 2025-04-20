{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.btop;
in
{
  options.${namespace}.cli-apps.btop = with types;
    {
      enable = mkEnableOption "Whether or not to enable btop.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ btop ]; };
}

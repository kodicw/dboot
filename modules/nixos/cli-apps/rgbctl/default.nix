{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.rgbctl;
in
{
  options.${namespace}.cli-apps.rgbctl = with types;
    {
      enable = mkEnableOption "Whether or not to enable genix.rgbctl.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ genix.rgbctl ]; };
}

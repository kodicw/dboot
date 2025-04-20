{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.gifpaper;
in
{
  options.${namespace}.cli-apps.gifpaper = with types;
    {
      enable = mkEnableOption "Whether or not to enable gifpaper.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ genix.gifpaper ]; };
}

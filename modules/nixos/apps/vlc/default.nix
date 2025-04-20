{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.vlc;
in
{
  options.${namespace}.apps.vlc = {
    enable = mkEnableOption "Whether or not to enable vlc.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ vlc ]; };
}

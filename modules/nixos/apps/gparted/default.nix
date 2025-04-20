{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.gparted;
in
{
  options.${namespace}.apps.gparted = {
    enable = mkEnableOption "Whether or not to enable gparted.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ gparted ]; };
}

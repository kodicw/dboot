{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.home-manager;
in
{
  options.${namespace}.cli-apps.home-manager = {
    enable = mkEnableOption "Whether or not to enable home-manager.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      home-manager
    ];
  };
}

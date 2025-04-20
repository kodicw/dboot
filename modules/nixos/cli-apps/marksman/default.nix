{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.marksman;
in
{
  options.${namespace}.cli-apps.marksman = {
    enable = mkEnableOption "Whether or not to enable marksman.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      marksman
    ];
  };
}

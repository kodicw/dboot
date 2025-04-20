{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.charm_sh.skate;
in
{
  options.${namespace}.cli-apps.charm_sh.skate = {
    enable = mkEnableOption "Whether or not to enable skate.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      skate
    ];
  };
}

{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.charm_sh.charm;
in
{
  options.${namespace}.cli-apps.charm_sh.charm = {
    enable = mkEnableOption "Whether or not to enable charm.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      charm
    ];
  };
}

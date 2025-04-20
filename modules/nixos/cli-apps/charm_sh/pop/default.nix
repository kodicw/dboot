{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.charm_sh.pop;
in
{
  options.${namespace}.cli-apps.charm_sh.pop = {
    enable = mkEnableOption "Whether or not to enable pop.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pop
    ];
  };
}

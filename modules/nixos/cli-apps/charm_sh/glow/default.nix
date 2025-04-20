{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.charm_sh.glow;
in
{
  options.${namespace}.cli-apps.charm_sh.glow = {
    enable = mkEnableOption "Whether or not to enable glow.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      glow
    ];
  };
}

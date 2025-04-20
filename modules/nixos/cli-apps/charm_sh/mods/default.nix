{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.charm_sh.mods;
in
{
  options.${namespace}.cli-apps.charm_sh.mods = {
    enable = mkEnableOption "whether or not to enable mods.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mods
    ];
  };
}

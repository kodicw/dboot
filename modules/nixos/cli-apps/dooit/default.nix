{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.dooit;
in
{
  options.${namespace}.cli-apps.dooit = with types;
    {
      enable = mkEnableOption "Whether or not to enable dooit.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ dooit ]; };
}

{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.mullvad;
in
{
  options.${namespace}.apps.mullvad = with types;
    {
      enable = mkEnableOption "Whether or not to enable mullvad.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ mullvad ]; };
}

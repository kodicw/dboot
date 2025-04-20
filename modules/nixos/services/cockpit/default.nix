{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.cockpit;
in
{
  options.${namespace}.services.cockpit = with types;
    {
      enable = mkEnableOption "Whether or not to configure cockpit";
    };

  config = mkIf cfg.enable {
    services.cockpit = {
      enable = true;
      openFirewall = true;
    };
  };
}

{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.starship;
in
{
  options.${namespace}.apps.starship = {
    enable = mkEnableOption "Whether or not to enable starship.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      starship
    ];
  };
}

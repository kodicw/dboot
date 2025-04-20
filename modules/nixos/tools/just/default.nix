{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.just;
in
{
  options.${namespace}.tools.just = {
    enable = mkEnableOption "Whether or not to enable just.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      just
    ];
  };
}

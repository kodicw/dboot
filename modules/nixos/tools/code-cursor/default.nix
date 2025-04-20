{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.code-cursor;
in
{
  options.${namespace}.tools.code-cursor = {
    enable = mkEnableOption "Whether or not to enable code-cursor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      code-cursor
    ];
  };
}

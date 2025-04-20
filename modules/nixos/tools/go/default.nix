{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.go;
in
{
  options.${namespace}.tools.go = {
    enable = mkEnableOption "Whether or not to enable go.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      go
      gopls
    ];
  };
}

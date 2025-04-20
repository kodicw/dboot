{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.javascript;
in
{
  options.${namespace}.tools.javascript = {
    enable = mkEnableOption "Whether or not to enable javascript.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bun
      nodejs
    ];
  };
}

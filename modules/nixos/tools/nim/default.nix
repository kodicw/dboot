{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.nim;
in
{
  options.${namespace}.tools.nim = with types;
    {
      enable = mkEnableOption "Whether or not to enable nim.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ nim nimble nimlsp ]; };
}

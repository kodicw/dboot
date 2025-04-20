{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.virtualenv;
in
{
  options.${namespace}.tools.virtualenv = with types;
    {
      enable = mkEnableOption "Whether or not to enable virtualenv.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ virtualenv ]; };
}

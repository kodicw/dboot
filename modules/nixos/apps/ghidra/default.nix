{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.ghidra;
in
{
  options.${namespace}.apps.ghidra = with types;
    {
      enable = mkEnableOption "Whether or not to enable ghidra.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ ghidra ]; };
}

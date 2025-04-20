{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.bottles;
in
{
  options.${namespace}.apps.bottles = with types; {
    enable = mkEnableOption "Whether or not to enable Bottles.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ bottles ]; };
}

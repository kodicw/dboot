{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.proton-pass;
in
{
  options.${namespace}.apps.proton-pass = with types;
    {
      enable = mkEnableOption "Whether or not to enable proton-pass.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ proton-pass ]; };
}

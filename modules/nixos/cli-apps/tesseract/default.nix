{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.tesseract;
in
{
  options.${namespace}.apps.tesseract = with types;
    {
      enable = mkEnableOption "Whether or not to enable tesseract.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ tesseract ]; };
}

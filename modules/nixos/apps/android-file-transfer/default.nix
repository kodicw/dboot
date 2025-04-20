{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.android-file-transfer;
in
{
  options.${namespace}.apps.android-file-transfer = with types;
    {
      enable = mkEnableOption "Whether or not to enable android-file-transfer.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ android-file-transfer ]; };
}

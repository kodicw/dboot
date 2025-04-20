{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.adb;
in
{
  options.${namespace}.cli-apps.adb = with types;
    {
      enable = mkEnableOption "Whether or not to enable adb.";
    };

  config =
    mkIf cfg.enable {
      programs.adb.enable = true;
      environment.systemPackages = [ pkgs.scrcpy pkgs.autoadb ];
    };
}

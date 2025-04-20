{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.taskwarrior;
in
{
  options.${namespace}.cli-apps.taskwarrior = {
    enable = mkEnableOption "Whether or not to enable taskwarrior.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      taskwarrior3
    ];
  };
}

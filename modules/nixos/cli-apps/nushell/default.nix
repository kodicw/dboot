{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.nushell;
in
{
  options.${namespace}.cli-apps.nushell = {
    enable = mkEnableOption "Whether or not to enable nushell.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nushell
    ];
    users.defaultUserShell = pkgs.nushell;
  };
}

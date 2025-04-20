{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.deploy-rs;
in
{
  options.${namespace}.cli-apps.deploy-rs = with types; {
    enable = mkEnableOption "Whether or not to enable deploy-rs.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ deploy-rs ]; };
}

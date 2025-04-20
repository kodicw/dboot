{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.wl-clipboard-rs;
in
{
  options.${namespace}.cli-apps.wl-clipboard-rs = with types;
    {
      enable = mkEnableOption "Whether or not to enable wl-clipboard-rs.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ wl-clipboard-rs ]; };
}

{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.tor-browser;
in
{
  options.${namespace}.apps.tor-browser = with types;
    {
      enable = mkEnableOption "Whether or not to enable tor-browser.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ tor-browser ]; };
}

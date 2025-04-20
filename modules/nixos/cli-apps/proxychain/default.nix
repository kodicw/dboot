{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.proxychains;
in
{
  options.${namespace}.cli-apps.proxychains = {
    enable = mkEnableOption "Whether or not to enable proxychain.";
  };
  config = mkIf cfg.enable {
    programs.proxychains = {
      enable = true;
      proxies = {
        "default" = {
          port = 1337;
          type = "socks5";
          host = "localhost";
        };
      };
    };
  };
}

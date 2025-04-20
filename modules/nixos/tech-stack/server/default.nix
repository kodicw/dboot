{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.techstack.server;
  bundles = {
    common = enabled;
    charm = enabled;
  };
in
{
  options.${namespace}.techstack.server = {
    enable = mkEnableOption "server.";
  };
  config = mkIf cfg.enable { genix = { inherit bundles; }; };
}

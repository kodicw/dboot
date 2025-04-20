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
  cfg = config.${namespace}.techstack.workstation;
  bundles = {
    common = enabled;
    desktop = enabled;
    art = enabled;
  };
in
{
  options.${namespace}.techstack.workstation = {
    enable = mkEnableOption "workstation.";
  };

  config = mkIf cfg.enable { genix = { inherit bundles; }; };
}

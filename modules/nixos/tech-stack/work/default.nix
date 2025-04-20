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
  cfg = config.${namespace}.techstack.work;

  bundles = {
    common = enabled;
    desktop = enabled;
    development = enabled;
  };
  apps = {
    bruno.enable = true;
    bottles.enable = true;
    gimp.enable = true;
    kdenlive.enable = true;
  };
in
{
  options.${namespace}.techstack.work = {
    enable = mkEnableOption "workstation.";
  };
  config = mkIf cfg.enable {
    genix = { inherit bundles apps; };
    environment.systemPackages = with pkgs; [
      slack
      _1password-gui
      _1password
      wireshark
      chromedriver

    ];
  };
}

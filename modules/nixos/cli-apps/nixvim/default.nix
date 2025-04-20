{ options
, config
, lib
, pkgs
, namespace
, system
, inputs
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.nixvim;
in
{
  options.${namespace}.cli-apps.nixvim = {
    enable = mkEnableOption "Whether or not to enable nixvim.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      genix.nixvim
    ];
  };
} 

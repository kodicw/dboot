{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.cc;
in
{
  options.${namespace}.tools.cc = {
    enable = mkEnableOption "Whether or not to enable cc.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang
    ];
  };
}

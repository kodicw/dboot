{ config
, lib
, pkgs
, namespace
, ...
}:
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.kitty;
in
{
  options.${namespace}.cli-apps.kitty = {
    enable = lib.mkEnableOption "Whether or not to enable kitty.";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}

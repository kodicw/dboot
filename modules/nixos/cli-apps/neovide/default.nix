{ options
, config
, lib
, pkgs
, namespace
, inputs
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.neovide;
in
{
  options.${namespace}.cli-apps.neovide = {
    enable = mkEnableOption "Whether or not to enable neovide.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovide
    ];
  };
}

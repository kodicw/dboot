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
  cfg = config.${namespace}.cli-apps.ags;
in
{
  options.${namespace}.cli-apps.ags = {
    enable = mkEnableOption "Whether or not to enable ags.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.ags.packages.${system}.ags
    ];
  };
}

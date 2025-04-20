{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.git;
in
{
  options.${namespace}.tools.git = {
    enable = mkEnableOption "Whether or not to enable git.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      lazygit
    ];
  };
}

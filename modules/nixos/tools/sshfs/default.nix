{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.sshfs;
in
{
  options.${namespace}.tools.sshfs = {
    enable = mkEnableOption "Whether or not to enable sshfs.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      sshfs
    ];
  };
}

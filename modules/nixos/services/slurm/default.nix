{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.slurm;
in
{
  options.${namespace}.services.slurm = with types;
    {
      enable = mkEnableOption "Whether or not to configure slurm";
    };

  config = mkIf cfg.enable {
    services.slurm.server.enable = true;
  };
}

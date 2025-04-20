{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.sops;
in
{
  options.${namespace}.tools.sops = with types;
    {
      enable = mkEnableOption "Whether or not to enable sops.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ sops ]; };
}

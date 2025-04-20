{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.iperf3;
in
{
  options.${namespace}.tools.iperf3 = {
    enable = mkEnableOption "Whether or not to enable iperf3.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iperf3
    ];
  };
}

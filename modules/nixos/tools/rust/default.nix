{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.rust;
in
{
  options.${namespace}.tools.rust = {
    enable = mkEnableOption "Whether or not to enable rust.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rustup
      cargo
      rust-analyzer
    ];
  };
}

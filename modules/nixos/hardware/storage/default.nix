{ options
, config
, pkgs
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.hardware.storage;
in
with lib;
with lib.${namespace};
{
  options.${namespace}.hardware.storage = {
    enable = mkEnableOption "Whether or not to enable support for extra storage devices.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ntfs3g fuseiso ];
  };
}

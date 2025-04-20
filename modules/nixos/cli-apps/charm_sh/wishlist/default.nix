{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.charm_sh.wishlist;
in
{
  options.${namespace}.cli-apps.charm_sh.wishlist = {
    enable = mkEnableOption "whether or not to enable wishlist.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wishlist
    ];
  };
}

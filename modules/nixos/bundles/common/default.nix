{ pkgs
, config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.common;
  cli-apps = {
    btop.enable = true;
    nushell.enable = true;
    fastfetch.enable = true;
    tmux.enable = true;
    proxychains.enable = true;
    aspell.enable = true;
  };
  tools = {
    git.enable = true;
    mosh.enable = true;
    sshfs.enable = true;
    iperf3.enable = true;
  };
  nix = {
    settings.enable = true;
    development.enable = true;
  };
in
{
  options.${namespace}.bundles.common.enable = mkEnableOption "common";
  config = mkIf cfg.enable {
    genix = { inherit cli-apps tools nix; };
  };
}

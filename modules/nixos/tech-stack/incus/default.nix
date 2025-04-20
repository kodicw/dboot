{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.techstack.incus;
in
{
  options.${namespace}.techstack.incus = {
    enable = mkEnableOption "incus.";
  };
  config = mkIf cfg.enable {
    users.users.root.subGidRanges = lib.mkForce [
      { count = 1; startGid = 100; }
      { count = 1000000000; startGid = 1000000; }
    ];
    users.users.root.subUidRanges = lib.mkForce [
      { count = 1; startUid = 1000; }
      { count = 1000000000; startUid = 1000000; }
    ];
    environment.systemPackages = with pkgs; [
      nfs-utils
      nettools
      zfs
      sshfs
      openvswitch
    ];
  };
}

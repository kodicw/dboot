{ config, pkgs, lib, namespace, ... }:
let
  groups = [
    "networkmanager"
    "wheel"
    "libvirtd"
    "docker"
    "audio"
    "dialout"
  ];
  cfg = config.${namespace}.user.charles;
in
with lib;
{
  options = {
    ${namespace}.user.charles.enable = mkEnableOption "Enable user charles";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        charles = {
          isNormalUser = true;
          useDefaultShell = true;
          initialHashedPassword = "$y$j9T$gSxRpeHmBy9Qt8Iz0gkEE0$6RYzT2krsz8HiAk.X.q3AVkMwpOL85FkayNFt.6saC4";
          description = "charles";
          extraGroups = groups;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiDe2CMnDgWjXqMpQHxCSOmrjuAWwZazYPORZXlr2SF u0_a518@localhost"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv8kP8LWCSGweBHEl/AmxKMLat2Y2RWonKqDSO6RrWb charles@mainframe"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILzx49PUFSJcyzSQH1x59VmF1quAyG6f87uf8cdpKLDu deck@steamdeck"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEAqHet7WTj97b3eX85U3BbeqK7QpdGcMy969DY8rTeq charles@node-nadia"
          ];
        };
      };
    };
  };
}


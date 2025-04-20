{ config
, lib
, pkgs
, namespace
, options
, ...
}:
let
  cfg = config.${namespace}.system.boot.grub;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.system.boot.grub = {
      enable = mkEnableOption "Enable GRUB EFI support";
      device = mkOption {
        type = types.str;
        default = "nodev";
        description = "The device to install GRUB on";
      };
      useOSProber = mkOption {
        type = types.bool;
        default = false;
        description = "Use os-prober to detect other operating systems";
      };
      efiSupport = mkOption {
        type = types.bool;
        default = true;
        description = "Enable EFI support";
      };
    };
  };
  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = cfg.device;
        useOSProber = cfg.useOSProber;
        efiSupport = cfg.efiSupport;
      };
    };
  };
}


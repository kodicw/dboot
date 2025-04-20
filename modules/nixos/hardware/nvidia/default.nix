{ config
, pkgs
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.hardware.nvidia;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.hardware.nvidia = {
      enable = lib.mkEnableOption "Enable Nvidia drivers";
      powerManagement = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Nvidia GPU power management";
      };
      open = mkOption {
        type = types.bool;
        default = false;
        description = "Enable open-source Nvidia drivers";
      };
      modesetting = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Nvidia modesetting";
      };
      version = mkOption {
        type = types.str;
        default = "beta";
        description = "Nvidia driver version";
      };
    };

  };
  config = lib.mkIf cfg.enable {
    # Install Nvidia GPU drivers
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    environment.systemPackages = with pkgs; [
      gwe
    ];
    hardware.nvidia = {
      modesetting.enable = cfg.modesetting;
      open = cfg.open;
      nvidiaSettings = true;
      powerManagement.enable = cfg.powerManagement;
      package = config.boot.kernelPackages.nvidiaPackages.${cfg.version};
    };
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}


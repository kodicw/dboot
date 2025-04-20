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
  cfg = config.${namespace}.techstack.battlestation;
  bundles = {
    common.enable = true;
    desktop.enable = true;
    art.enable = true;
    gaming.enable = true;
    development.enable = true;
    hyprland.enable = true;
    networking.enable = true;
  };
  apps = {
    kdeconnect.enable = true;
    bruno.enable = true;
    prusa-slicer.enable = true;
    ulauncher.enable = true;
  };
  services = {
    openrgb.enable = true;
    openssh.enable = true;
    cron.enable = true;
    tailscale.enable = true;
    usb-automount.enable = true;
  };
  virtualisation = {
    docker.enable = true;
    virt-manager.enable = true;
    vmVariant.enable = true;
  };
  cli-apps = {
    rgbctl.enable = true;
    adb.enable = true;
    taskwarrior.enable = true;
  };
in
{
  options.${namespace}.techstack.battlestation = {
    enable = mkEnableOption "battlestation.";
  };

  config = mkIf cfg.enable { genix = { inherit bundles apps cli-apps services virtualisation; }; };
}

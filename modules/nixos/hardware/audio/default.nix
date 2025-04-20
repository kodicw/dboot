{ options
, config
, pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.hardware.audio;
in
{
  options.${namespace}.hardware.audio = {
    enable = mkEnableOption "Whether or not to enable audio support.";
    # extra-packages = mkOption (listOf package) [
    #   pkgs.qjackctl
    #   pkgs.easyeffects
    # ] "Additional packages to install.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    hardware.pulseaudio.enable = mkForce false;

    environment.systemPackages = with pkgs;
      [
        pulsemixer
        pavucontrol
      ];
    # ++ cfg.extra-packages;
  };
}

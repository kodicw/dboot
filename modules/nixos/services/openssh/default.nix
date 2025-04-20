{ config
, pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.openssh;
in
{
  options.${namespace}.services.openssh = {
    enable = mkEnableOption "Whether or not to configure OpenSSH support.";
    mosh = mkEnableOption "Whether or not to install mosh.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        # PermitRootLogin =
        #   if format == "install-iso"
        #   then "yes"
        #   else "no";
        PasswordAuthentication = false;
      };
    };
    environment.systemPackages = mkIf cfg.mosh [
      pkgs.mosh
    ];

  };
}

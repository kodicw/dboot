{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.cage;
in
{
  options.${namespace}.services.cage = with types;
    {
      enable = mkEnableOption "Whether or not to configure cage";
    };

  config = mkIf cfg.enable
    {

      systemd.services."cagefox" = {
        enable = true;
        after = [ "systemd-user-sessions.service" "dbus.socket" "systemd-logind.service" "getty@%i.service" "plymouth-deactivate.service" "plymouth-quit.service" ];
        before = [ "graphical.target" ];
        wants = [ "dbus.socket" "systemd-logind.service" "plymouth-deactivate.service" ];
        wantedBy = [ "graphical.target" ];
        conflicts = [ "getty@%i.service" ]; # "plymouth-quit.service" "plymouth-quit-wait.service"

        restartIfChanged = true;
        serviceConfig = {
          ExecStart = "${pkgs.cage}/bin/cage ${pkgs.firefox}/bin/firefox -- -kiosk http://127.0.0.1:8123";
          User = "kiosk";

          # ConditionPathExists = "/dev/tty0";
          IgnoreSIGPIPE = "no";

          # Log this user with utmp, letting it show up with commands 'w' and
          # 'who'. This is needed since we replace (a)getty.
          UtmpIdentifier = "%I";
          UtmpMode = "user";
          # A virtual terminal is needed.
          TTYPath = "/dev/%I";
          TTYReset = "yes";
          TTYVHangup = "yes";
          TTYVTDisallocate = "yes";
          # Fail to start if not controlling the virtual terminal.
          StandardInput = "tty-fail";
          StandardOutput = "syslog";
          StandardError = "syslog";
          # Set up a full (custom) user session for the user, required by Cage.
          PAMName = "cage";
        };
      };

      security.pam.services.cage.text = ''
        auth    required pam_unix.so nullok
        account required pam_unix.so
        session required pam_unix.so
        session required ${pkgs.systemd}/lib/security/pam_systemd.so
      '';

      systemd.targets.graphical.wants = [ "cage@tty1.service" ];

      systemd.defaultUnit = "graphical.target";

      users.users.kiosk = {
        isNormalUser = true;
        description = "Demo user account";
        extraGroups = [ "wheel" ];
        password = "demo";
        uid = 100020;
      };

      # Whitelist wheel users to do anything
      # This is useful for things like pkexec
      #
      # WARNING: this is dangerous for systems
      # outside the installation-cd and shouldn't
      # be used anywhere else.
      # security.polkit.extraConfig = ''
      #   polkit.addRule(function(action, subject) {
      #     if (subject.isInGroup("wheel")) {
      #       return polkit.Result.YES;
      #     }
      #   });
      # '';

      # security.sudo = {
      #   enable = true;
      #   wheelNeedsPassword = false;
      # };

    };
}

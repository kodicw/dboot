{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.nix.settings;
in
{
  options.${namespace}.nix.settings = {
    enable = mkEnableOption "Nix settings and packages.";
  };
  config = mkIf cfg.enable {
    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        trusted-users = [ "charles" "root" ];
        # sandbox = "relaxed";
        auto-optimise-store = true;
        # trusted-users = users;
        # allowed-users = users;
        # gc.automatic = true;
        # flake-utils-plus
        # generateRegistryFromInputs = true;
        # generateNixPathFromInputs = true;
        # linkInputs = true;
      };
    };
  };
}

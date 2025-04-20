{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.nix.development;
in
{
  options.${namespace}.nix.development = {
    enable = mkEnableOption "Nix settings and packages.";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nixpkgs-fmt
      manix
      nurl
      deploy-rs
      nixos-anywhere
    ];
  };
}

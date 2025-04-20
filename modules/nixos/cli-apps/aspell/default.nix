{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.aspell;
in
{
  options.${namespace}.cli-apps.aspell = with types;
    {
      enable = mkEnableOption "Whether or not to enable aspell.";
    };

  config =
    mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        (aspellWithDicts (d: with d; [
          en
          en-science
          en-computers
        ]))
      ];
    };
}

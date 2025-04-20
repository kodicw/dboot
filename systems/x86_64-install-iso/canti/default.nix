{ namespace
, ...
}:
{
  ${namespace} = {
    user = {
      charles.enable = true;
      root.enable = true;
    };

    system = {
      locale.enable = true;
      fonts.enable = true;
      time.enable = true;
      xkb.enable = true;
    };

    bundles = {
      common.enable = true;
      development.enable = true;
    };

    nix = {
      settings.enable = true;
      development.enable = true;
    };

    services = {
      openssh.enable = true;
    };

    apps = {
      gparted.enable = true;
    };
  };

  networking = {
    hostName = "canti";
  };
}

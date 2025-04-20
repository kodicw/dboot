# nix run github:nix-community/nixos-anywhere -- --flake '.#infra-wall' --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --target-host root@192.168.1.218
{ lib
, namespace
, modulesPath
, ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  ${namespace} = {
    user.charles.enable = true;
    user.root.enable = true;

    system = {
      locale.enable = true;
      time.enable = true;
      xkb.enable = true;
      disko.btrfs = {
        enable = true;
        device = "/dev/sda";
      };
    };

    services = {
      openssh.enable = true;
    };
  };

  networking = {
    nftables.enable = true;
    hostName = "touchsmart";
  };

  virtualisation.incus = {
    enable = true;
    ui.enable = true;
  };

  system.stateVersion = "24.11";
}

{ config, lib, pkgs, ... }:

let
  cfg = config.services.opentitan-provisioning;
  anyEnabled = cfg.pa.enable || cfg.spm.enable || cfg.pb.enable;
in {
  imports = [
    ./pa.nix
    ./spm.nix
    ./pb.nix
  ];

  config = lib.mkIf anyEnabled {
    users.groups.opentitan = lib.mkDefault { };
    users.users.opentitan = lib.mkDefault {
      isSystemUser = true;
      group = "opentitan";
      description = "OpenTitan provisioning services daemon user";
      home = "/var/lib/opentitan";
      createHome = false;
    };
  };
}

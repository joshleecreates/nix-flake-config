{ config, pkgs, ... }:

{
  imports = [
    ../vm/hardware-configuration.nix
    ../vm/configuration.nix
    ../../users/kasti.nix
    ../../modules/node-exporter.nix
  ];
}

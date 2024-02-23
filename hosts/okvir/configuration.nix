{ config, pkgs, ... }:

{
  imports = [
    ../vm/configuration.nix
    ../vm/hardware-configuration.nix
    ../common/nodhcp.nix
    ../../modules/node-exporter.nix
    ../../users/kasti.nix
  ];

  networking.hostName = "okvir";
  networking.interfaces.eth0.ipv4.addresses = [ {
    address = "192.168.0.101";
    prefixLength = 24;
  } ];

  networking.firewall = {
    enable = false;
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "23.11";
}


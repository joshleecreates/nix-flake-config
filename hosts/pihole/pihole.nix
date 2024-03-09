{ config, pkgs, ... }:

{
  imports = [
    ../vm/configuration.nix
    ../vm/hardware-configuration.nix
    ../common/nodhcp.nix
    ../common/swap.nix
    ../../modules/node-exporter.nix
    ../../modules/pihole.nix
    ../../modules/tailscale.nix
    ../../users/kasti.nix
  ];

  networking.hostName = "pihole";
  networking.interfaces.eth0.ipv4.addresses = [ {
    address = "192.168.0.98";
    prefixLength = 24;
  } ];

  networking.firewall = {
    enable = false;
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "23.11";
}


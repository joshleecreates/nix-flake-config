{ config, pkgs, ... }:

{
  networking.networkmanager.enable = false;
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" ];
}

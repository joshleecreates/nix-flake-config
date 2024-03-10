{ config, pkgs, ... }:

{
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "192.168.0.100" ];
}

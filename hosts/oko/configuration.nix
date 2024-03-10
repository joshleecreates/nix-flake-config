{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../vm/configuration.nix
    ../../modules/ssh.nix
    ../common/nodhcp.nix
    ../../modules/tailscale.nix
    ../../modules/prometheus.nix
    ../../users/kasti.nix
  ];

  networking.hostName = "oko";
  networking.interfaces.eth0.ipv4.addresses = [ {
    address = "192.168.0.101";
    prefixLength = 24;
  } ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 2342 9001 9002 ];
  };

  environment.systemPackages = with pkgs; [
    vim 
    git
  ];

  services.nginx.enable = true;

  system.stateVersion = "23.11";
}


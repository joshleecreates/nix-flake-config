# pihole.nix

{ ... }:

{
  imports = [
    ../templates/server.nix
    ../../modules/pihole.nix
    ../../modules/tailscale.nix
  ];

  networking.hostName = "pihole";
  networking.interfaces.eth0.ipv4.addresses = [ {
    address = "192.168.0.100";
    prefixLength = 24;
  } ];

  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" ];

  networking.firewall = {
    enable = false;
  };

  system.stateVersion = "23.11";
}


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
    git # just in case
    python3 # required for ansible
  ];

  services.nginx.enable = true;

  services.nginx.virtualHosts."pihole.kasti.me" = {
    locations."/" = {
        proxyPass = "http://192.168.0.100:80";
        proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."truenas.kasti.me" = {
    locations."/" = {
        proxyPass = "http://192.168.0.98:80";
        proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."proxmox.kasti.me" = {
    locations."/" = {
      proxyPass = "https://192.168.0.11:8006";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."omv.kasti.me" = {
    locations."/" = {
      proxyPass = "http://192.168.0.204:80";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
        extraConfig = 
          "proxy_set_header Host grafana.kasti.me;" 
        ;
    };
  };

  services.nginx.virtualHosts."prometheus.kasti.me" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:9001";
      proxyWebsockets = true;
    };
  };

  system.stateVersion = "23.11";
}


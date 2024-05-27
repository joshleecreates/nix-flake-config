{ ... }:

{
  imports = [
    ./templates/server.nix
    ../modules/tailscale.nix
  ];

  networking.hostName = "ingress";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
  };

  services.nginx.enable = true;

  services.nginx.virtualHosts."pihole.kasti.me" = {
    locations."/" = {
        proxyPass = "http://192.168.0.100:80";
        proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."truenas.kasti.me" = {
    locations."/" = {
        proxyPass = "http://truenas.vms.tsoon.me";
        proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."proxmox.kasti.me" = {
    locations."/" = {
      proxyPass = "https://proxmox.svc.tsoon.me:8006";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."omv.kasti.me" = {
    locations."/" = {
      proxyPass = "http://omv.vms.tsoon.me";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."*.kasti.me" = {
    locations."/" = {
      proxyPass = "http://monitoring.vms.tsoon.me";
      recommendedProxySettings = true;
    };
  };
}


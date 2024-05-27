{ config, pkgs, ... }:
let
  hostname = "bedrock-monitor";
  domain = "mora-mirzam.ts.net";
  fqdn = hostname + "." + domain;
in
{
  imports = [
    ../templates/server.nix
    ../../modules/tailscale.nix
  ];

  networking.hostName = hostname;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 2342 9001 9002 ];
  };

  services.grafana.enable = true;
  services.grafana.settings.server = {
    domain = fqdn;
    http_port = 2342;
    http_addr = "0.0.0.0";
    root_url = "%(protocol)s://%(domain)s:%(http_port)s/grafana/";
  };

  services.grafana.settings.database = {
    type = "postgres";
    host = "192.168.0.188";
    user = "grafana";
    password = "grafana";
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts.${fqdn} = {
    locations."/grafana/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      extraConfig = ''
        rewrite ^/grafana/(.*) /$1 break;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
      '';
    };
    locations."/prometheus" = {
      proxyPass = "http://127.0.0.1:9001";
      proxyWebsockets = true;
    };
  };

  system.stateVersion = "23.11";
}


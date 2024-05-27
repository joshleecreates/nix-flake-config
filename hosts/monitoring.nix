{ config, ... }:
let
  hostname = "monitoring";
  db_host  = "postgres.svc.tsoon.me"; #todo: use different domain
in
{
  imports = [
    ./templates/server.nix
    ../modules/influxdb.nix
  ];

  networking.hostName = hostname;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 2342 9001 9002 9090 ];
  };

  services.grafana.enable = true;
  services.grafana.settings.server = {
    http_port = 2342;
    http_addr = "0.0.0.0";
  };
  services.grafana.settings.database = {
    type = "postgres";
    host = db_host; 
    user = "grafana";
    password = "grafana"; #todo: make secure
  };

  services.prometheus = {
    enable = true;
    port = 9001;
    globalConfig = {
      scrape_timeout = "10s";
      scrape_interval = "15s";
    };
    scrapeConfigs = [
      {
        job_name = "Node";
        static_configs = [{
          targets = [ 
            "heart-of-gold.local:9100"
            "pihole.local:9002"
            "kasti.local:9002"
            "ingress.local:9002"
            "monitoring.local:${toString config.services.prometheus.exporters.node.port}"
            "db-primary.local:9002"
          ];
        }];
      }
    ];
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."grafana.*" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
      '';
    };
  };
  services.nginx.virtualHosts."prometheus.*" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:9001";
    };
  };
  services.nginx.virtualHosts."influxdb.*" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8086";
      proxyWebsockets = true;
    };
  };

  system.stateVersion = "23.11";
}

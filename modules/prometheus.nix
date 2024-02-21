{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    port = 9001;
  };

  services.grafana.enable = true;
  services.grafana.settings.server = {
    domain = "grafana.home.arpa";
    http_port = 2342;
    http_addr = "0.0.0.0";
  };

  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9002;
      };
    };
    scrapeConfigs = [
      {
        job_name = "oko";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "r7";
        static_configs = [{
          targets = [ "192.168.0.99:9100" ];
        }];
      }
    ];
  };

  # nginx reverse proxy
  services.nginx.virtualHosts.${config.services.grafana.domain} = {
    locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.port}";
        proxyWebsockets = true;
    };
  };
}

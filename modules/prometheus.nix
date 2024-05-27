{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    port = 9001;
  };

  services.grafana.enable = true;
  services.grafana.settings.server = {
    domain = "grafana.kasti.me";
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
    globalConfig = {
      scrape_timeout = "25s";
      scrape_interval = "30s";
    };
    scrapeConfigs = [
      {
        job_name = "vms";
        static_configs = [{
          targets = [ 
            "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
            "pihole:9002"
            "kasti.local:9002"
          ];
        }];
      }
      {
        job_name = "r7";
        static_configs = [{
          targets = [ "192.168.0.11:9100" ];
        }];
      }
    ];
  };
}

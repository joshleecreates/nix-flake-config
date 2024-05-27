{ config, pkgs, ... }:
let
  prometheus_exporter_port = 9002;
in
{
  networking.firewall.allowedTCPPorts = [ prometheus_exporter_port ];
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = prometheus_exporter_port;
      };
    };
  };
}

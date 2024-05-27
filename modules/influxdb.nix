{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 8086 ];
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = false;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    influxdb = {
      image = "influxdb:2.7.6";
      ports = [
        "8086:8086"
      ];
      volumes = [
        "/var/lib/influxdb2/:/var/lib/influxdb2:rw"
      ];
      autoStart = true;
    };
  };
}

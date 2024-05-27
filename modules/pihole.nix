{ config, pkgs, ...}: 

{
  services.resolved = {
    extraConfig = ''
      DNSStubListener=no
    '';
  };
  networking.firewall.allowedTCPPorts = [ 53 80 443 9443 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = false;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    pihole = {
      image = "pihole/pihole:latest";
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "80:80"
        "443:443"
      ];
      volumes = [
        "/var/lib/pihole/:/etc/pihole/"
        "/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
      ];
      environment = {
        TZ = "America/New_York";
        VIRTUAL_HOST = "pihole.kasti.me";
      };
      autoStart = true;
    };
  };
}

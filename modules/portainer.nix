{ config, pkgs, ... }:

{
  virtualisation.docker.enable = false;
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer/portainer-ce";
      ports = [
        "8000:8000"
        "9443:9443"
      ];
      volumes = [
        "appdata:/data"
        "/var/run/podman/podman.sock:/var/run/docker.sock:Z"
      ];
      extraOptions = [
        "--privileged"
      ];
    };  
  };
}

{ config, pkgs, ... }:

{
  imports = [
    ../vm/configuration.nix
    ../vm/hardware-configuration.nix
    ../../modules/node-exporter.nix
    ../../modules/portainer.nix
    ../../users/kasti.nix
  ];

  networking.hostName = "lab-docker";

  networking.firewall = {
    enable = false;
  };

  environment.systemPackages = with pkgs; [
  ];

  system.stateVersion = "23.11";
}


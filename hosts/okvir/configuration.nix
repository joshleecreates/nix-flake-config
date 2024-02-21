{ config, pkgs, ... }:

{
  # @TODO: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/proxmox-image.nix
  imports = [
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/portainer.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../users/kasti.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  swapDevices = [
    { device = "/swapfile"; size = 1024; } # Size in MB
  ];
  networking.hostName = "okvir";
  networking.networkmanager.enable = false;
  networking.interfaces.eth0.ipv4.addresses = [ {
    address = "192.168.0.100";
    prefixLength = 24;
  } ];
  services.qemuGuest.enable = true;

  networking.firewall = {
    enable = false;
    # allowedTCPPorts = [ ];
  };

  environment.systemPackages = with pkgs; [
    vim 
    git
  ];

  system.stateVersion = "23.11";
}


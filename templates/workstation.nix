{ config, pkgs, lib, ... }:

{
  # Custom Settings
  extras.passwordlessSSH.enable = lib.mkDefault true;
  extras.remoteUpdates.enable = lib.mkDefault true;

  networking.hostName = lib.mkDefault "workstation";
  networking.networkmanager.enable = lib.mkDefault true;
  networking.firewall.enable = lib.mkDefault false;

  nixpkgs.config.allowUnfree = lib.mkDefault true;
  virtualisation.docker.enable = lib.mkDefault true;
  services.tailscale.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    home-manager 
    git
    python3
    dnsutils
  ];

  system.stateVersion = lib.mkDefault "24.05";
}

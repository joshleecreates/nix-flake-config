{ config, pkgs, ... }:

{
  imports = [
    ../vm/configuration.nix
    ../vm/hardware-configuration.nix
    ../common/i18n.nix
    ../common/security.nix
    ../common/ssh.nix
    ../../modules/tailscale.nix
    ../../modules/node-exporter.nix
    ../../users/josh.nix
  ];

  networking.hostName = "kasti";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;
  services.qemuGuest.enable = true;

  nix.settings.trusted-users = [ "root" "@wheel" ];

  environment.systemPackages = with pkgs; [
    home-manager 
    git
  ];

  boot.growPartition = true;
  system.stateVersion = "23.11";
}


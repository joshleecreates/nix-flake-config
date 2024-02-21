{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/grub.nix
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../modules/prometheus.nix
    ../../users/kasti.nix
  ];

  networking.hostName = "oko";
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.qemuGuest.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 2342 9001 9002 ];
  };

  environment.systemPackages = with pkgs; [
    vim 
    git
  ];

  system.stateVersion = "23.11";
}


{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../users/josh.nix
  ];

  networking.hostName = "kasti";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    home-manager 
    git
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda/" ];

  system.stateVersion = "23.11";
}


# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/grub.nix
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../users/josh.nix
  ];

  system.stateVersion = "23.11"; # Did you read the comment?

  networking.hostName = "kasti"; # Define your hostname.
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    home-manager 
  ];

}


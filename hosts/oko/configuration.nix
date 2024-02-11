{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../common/grub.nix
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../users/kasti.nix
  ];

  networking.hostName = "oko";
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  virtualisation.docker.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
  ];

  system.stateVersion = "23.11";
}


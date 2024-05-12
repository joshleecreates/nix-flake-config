{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/ssh.nix
  ];

  services.qemuGuest.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];


  nix.settings.trusted-users = [ "root" "@wheel" ];

  environment.systemPackages = with pkgs; [
    vim 
    git
  ];

  system.stateVersion = "23.11";
}


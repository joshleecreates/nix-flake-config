{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../common/i18n.nix
    ../common/security.nix
    ../../modules/ssh.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];

  nix.settings.trusted-users = [ "root" "@wheel" ];

  services.qemuGuest.enable = true;

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish = {
    enable = true;
    addresses = true;
  };

  environment.systemPackages = with pkgs; [
    vim 
    git
    python3 # for ansible
  ];

  system.stateVersion = "23.11";
}


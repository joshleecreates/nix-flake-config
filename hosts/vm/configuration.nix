{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../common/i18n.nix
    ../common/ssh.nix
  ];

  # Enable QEMU Guest for Proxmox
  services.qemuGuest.enable = true;

  # Use the boot drive for grub
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];

  # Allow remote updates with flakes and non-root users
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable mDNS for `hostname.local` addresses
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish = {
    enable = true;
    addresses = true;
  };

  # Some sane packages we need on every system
  environment.systemPackages = with pkgs; [
    vim  # for emergencies
    git # for pulling nix flakes
    python3 # for ansible
  ];

  # Don't ask for passwords
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.11";
}


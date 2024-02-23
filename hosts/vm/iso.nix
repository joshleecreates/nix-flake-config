{ config, pkgs, modulesPath, ... }:

{
  # @TODO: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/proxmox-image.nix
  imports = [
    ../../users/kasti.nix
  ];

  networking.hostName = "new-vm";
  networking.networkmanager.enable = true;
}

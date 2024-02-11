{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda/" ];
}

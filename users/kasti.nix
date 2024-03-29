{ config, pkgs, ... }:

{
  users.users.kasti = {
    isNormalUser = true;
    description = "Kasti Service Account";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  users.users.kasti.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTo7OPWSsPKdxz69sr89NYqKYhYGeyKSnpmY7xPmz2n josh@joshuamlee.com"
  ];
}

{ ... }:

{
  security.sudo.wheelNeedsPassword = false;

  users.users.kasti = {
    isNormalUser = true;
    description = "Kasti Service Account";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  users.users.kasti.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTo7OPWSsPKdxz69sr89NYqKYhYGeyKSnpmY7xPmz2n josh@joshuamlee.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHHvxOTX0LSZh1HbKiAx5zZwXR7OvhbgG3bTbwOsTqGV josh@joshuamlee.com"
  ];
}

{ config, pkgs, ...}: 

{
  swapDevices = [
    { device = "/swapfile"; size = 1024; } # Size in MB
  ];
}

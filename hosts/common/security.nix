{ config, pkgs, ...}: 

{
  # Don't ask for sudo password
  security.sudo.wheelNeedsPassword = false;
}

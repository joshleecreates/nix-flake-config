{ self, inputs, ... }:

{
  imports = [
    "${self}/templates/workstation.nix"
    "${inputs.my-modules}/profiles/vm.nix"
    "${self}/users/josh.nix"
    ../../common/locale.nix
  ];

  home-manager.users.josh = {
    imports = [ "${self}/homes/josh.nix" ];

    home.stateVersion = "23.11";
  };

  nix.settings.trusted-substituters = [ "https://cache.flox.dev" ];
  nix.settings.trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];
  networking.hostName = "kasti";
  system.stateVersion = "23.11";
}


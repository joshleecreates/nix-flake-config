{ self, pkgs, inputs, ... }:

{
  imports = [
    "${inputs.my-modules}/modules/default.nix"
    "${inputs.my-modules}/templates/workstation.nix"
    "${inputs.my-modules}/profiles/vm.nix"
    "${self}/users/josh.nix"
    "${self}/common/locale.nix"
  ];

  networking.hostName = "kasti";

  oci-services.enable = true;
  environment.systemPackages = [
    pkgs.docker-compose
  ];

  home-manager.users.josh = {
    imports = [ "${self}/homes/josh.nix" ];

    # Override neovim theme
    programs.neovim.plugins = with pkgs.vimPlugins; [{
      plugin = gruvbox;
      type = "lua";
      config = ''
        vim.cmd[[colorscheme gruvbox]]
      '';
    }];

    # Override oh-my-zsh theme
    programs.zsh.oh-my-zsh.theme = "robbyrussell";
    
    # Pin state version
    home.stateVersion = "23.11";
  };

  # Enable flox (see flox.dev)
  nix.settings.trusted-substituters = [ "https://cache.flox.dev" ];
  nix.settings.trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];

  # Pin state version
  system.stateVersion = "23.11";
}


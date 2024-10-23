{ self, pkgs, inputs, ... }:

{
  imports = [
    "${inputs.my-modules}/templates/desktop.nix"
    "${inputs.my-modules}/profiles/vm.nix"
    "${self}/users/josh.nix"
    "${self}/common/locale.nix"
  ];

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  networking.hostName = "desktop";
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
    home.stateVersion = "24.05";
  };

  # Enable flox (see flox.dev)
  nix.settings.trusted-substituters = [ "https://cache.flox.dev" ];
  nix.settings.trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];

  # Pin state version
  system.stateVersion = "24.05";
}


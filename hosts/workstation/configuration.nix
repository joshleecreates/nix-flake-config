{ self, pkgs, inputs, ... }:
{
  imports = [
    "${inputs.my-modules}/templates/workstation.nix"
    "${inputs.my-modules}/profiles/vm.nix"
    "${self}/users/josh.nix"
    "${self}/common/locale.nix"
  ];

  networking.hostName = "workstation";
  virtualisation.docker.enable = true;
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

  # Pin state version
  system.stateVersion = "24.05";
}


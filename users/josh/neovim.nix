{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup()
        '';
      }
      telescope-nvim
      telescope-zoxide
      vim-tmux-navigator
      tokyonight-nvim
    ];
    extraConfig = ''
      colorscheme tokyonight
      :luafile ~/.config/nvim/options.lua
      :luafile ~/.config/nvim/keymaps.lua
    '';
  };
  xdg.configFile.nvim = {
    source = ./config/neovim;
    recursive = true;
  };
}

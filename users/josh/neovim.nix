{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-web-devicons
      nvim-treesitter.withAllGrammars
      telescope-zoxide
      vim-tmux-navigator
      tokyonight-nvim
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
          local conform = require("conform")

          conform.setup({
            formatters_by_ft = {
              javascript = { "prettier" },
              typescript = { "prettier" },
              javascriptreact = { "prettier" },
              typescriptreact = { "prettier" },
              svelte = { "prettier" },
              css = { "prettier" },
              html = { "prettier" },
              json = { "prettier" },
              yaml = { "prettier" },
              markdown = { "prettier" },
              graphql = { "prettier" },
              lua = { "stylua" },
              python = { "isort", "black" },
            },
            format_on_save = {
              lsp_fallback = true,
              async = false,
              timeout_ms = 1000,
            },
          })

          vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
              lsp_fallback = true,
              async = false,
              timeout_ms = 1000,
            })
          end, { desc = "Format file or range (in visual mode)" })
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require("Comment").setup()
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require("lualine").setup()
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup()
        '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          vim.o.timeout = true
          vim.o.timeoutlen = 500
          require("which-key").setup()
        '';
      }
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

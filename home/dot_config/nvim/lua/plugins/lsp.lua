local config = require("ppm.utils").lazy_config

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        -- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = config("lsp"),
    event = "VeryLazy",
  },

  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    init = config("lspsaga_setup"),
    config = config("lspsaga"),
    event = "LspAttach",
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = { "nvim-lspconfig" },
    event = "LspAttach",
    init = function()
      vim.diagnostic.config({
        virtual_lines = { only_current_line = true, highighlight_whole_line = false },
        virtual_text = false,
      })
    end,
    keys = {
      { "<Leader>gl", function() require("lsp_lines").toggle() end, { desc = "Toggle LSP diagnostic lines" } }
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
  },
}
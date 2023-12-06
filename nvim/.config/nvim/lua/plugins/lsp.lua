local F = require("ppm.toolkit.fp.function")
local A = require("ppm.toolkit.fp.Array")
local ft = require("ppm.filetype")
local config = require("ppm.utils").lazy_config

return {
  {
    "folke/neodev.nvim",
    event = "VeryLazy",
  },

  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    opts = {
      text = { spinner = "moon" }
    },
    event = "VeryLazy",
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
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
  },

  {
    "jose-elias-alvarez/typescript.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim"
    },
    config = config("typescript"),
    ft = F.pipe(ft.typescript, A.append("markdown.mdx")),
  },

  {
    "marilari88/twoslash-queries.nvim",
    opts = {
      multi_line = true,
    },
    ft = ft.typescript
  },
}
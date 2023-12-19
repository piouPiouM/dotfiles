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
    "pmizio/typescript-tools.nvim",
    build = "npm i -g @styled/typescript-styled-plugin typescript-styled-plugin",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = F.pipe(ft.typescript, A.append("markdown.mdx")),
    opts = {
      on_attach = function(client, bufnr)
        local u = require("ppm.utils")
        require("twoslash-queries").attach(client, bufnr)

        u.buf_map(bufnr, "n", "go", ":TSToolsOrganizeImports<CR>")
      end,

      expose_as_code_action = "all",
      jsx_close_tag = {
        enable = true,
        filetypes = ft.jsx,
      },

      tsserver_plugins = {
        -- for TypeScript v4.9+
        "@styled/typescript-styled-plugin",
        -- or for older TypeScript versions
        -- "typescript-styled-plugin",
      },
    },
  },

  {
    "marilari88/twoslash-queries.nvim",
    opts = {
      multi_line = true,
    },
    ft = ft.typescript,
  },
}
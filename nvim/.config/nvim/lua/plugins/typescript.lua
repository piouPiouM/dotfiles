local F = require("ppm.toolkit.fp.function")
local A = require("ppm.toolkit.fp.Array")
local ft = require("ppm.filetype")

return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
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
      is_enabled = true,
    },
    ft = ft.typescript,
    keys = {
      { "<leader>,", ":TwoslashQueriesInspect<CR>", mode = "n", desc = "Inspect twoslash queries" },
      { "<leader>?", ":TwoslashQueriesRemove<CR>", mode = "n", desc = "Remove twoslash queries" },
    },
  },

  {
    'dmmulroy/ts-error-translator.nvim',
    ft = ft.typescript,
    opts = {},
  },

  {
    'dmmulroy/tsc.nvim',
    ft = ft.typescript,
    opts = {},
  },
}
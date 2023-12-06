local ft = require("ppm.filetype")

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "astro",
    "awk",
    "bash",
    "comment",
    "css",
    "diff",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "html",
    "ini",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "query",
    "regex",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
  sync_install = false,

  modules = {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = true },
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },

  -- Plugins
  autotag = { enable = true },
  textobjects = {
    enable = true,
    swap = {
      enable = true,
      swap_next = {
        ["<leader>gs"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>gS"] = "@parameter.inner",
      },
    },
  },
  textsubjects = {
    enable = true,
    prev_selection = ",",
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
      ["i;"] = "textsubjects-container-inner",
    },
  },
})

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs(a, b)
parser_config.tsx.filetype_to_parsername = ft.typescript
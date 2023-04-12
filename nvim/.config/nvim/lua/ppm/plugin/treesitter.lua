require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "astro",
    "bash",
    "comment",
    "css",
    "dockerfile",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "rasi",
    "regex",
    "rust",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },

  -- Plugins
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false, -- Disable CursorHold to work with Comment.nvim
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

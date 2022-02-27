if vim.g.loaded_indent_blankline ~= 1 then return nil end

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  bufname_exclude = { "NERD_tree.*", "startify", "fzf", "vim-plug" },
  filetype_exclude = { "markdown", "json", "help" },
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = false,
}

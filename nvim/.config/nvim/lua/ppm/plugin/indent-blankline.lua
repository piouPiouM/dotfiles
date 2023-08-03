vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  bufname_exclude = { "NERD_tree.*", "startify", "fzf", "vim-plug", "lspsagaoutline" },
  filetype_exclude = { "markdown", "help", "packer", "Trouble" },
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = false,
}

vim.opt.list = true

require("indent_blankline").setup {
  bufname_exclude = { "NERD_tree.*", "startify", "fzf", "vim-plug", "lspsagaoutline" },
  filetype_exclude = { "markdown", "help", "packer", "Trouble" },
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = false,
}

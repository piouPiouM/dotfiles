vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("ibl").setup {
  exclude = {
    filetypes = { "Trouble" },
    buftypes = { "NERD_tree.*", "startify", "fzf", "lspsagaoutline" },
  },
  scope = {
    show_start = false,
  }
}
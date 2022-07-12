local M = {}

M.setup = function()
  require("catppuccin").setup({
    term_colors = true,
    integrations = {
      gitgutter = true,
      gitsigns = false,
      hop = true,
      lsp_trouble = true,
      markdown = true,
      telescope = true,
      native_lsp = {
        underlines = {
          errors = "undercurl",
          hints = "undercurl",
          warnings = "undercurl",
          information = "undercurl",
        },
      },
      nvimtree = { enabled = false },
      neotree = { enabled = false },
      indent_blankline = { enabled = false },
    },
  })
end

M.use = function()
  vim.g.catppuccin_flavour = "latte"
  vim.cmd [[colorscheme catppuccin]]
end

return M

local M = {}

M.setup = function()
  require("catppuccin").setup({
    term_colors = true,
    integrations = {
      cmp = true,
      fidget = true,
      gitgutter = false,
      gitsigns = true,
      hop = true,
      lsp_saga = true,
      lsp_trouble = true,
      markdown = true,
      neotree = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      indent_blankline = { enabled = true, colored_indent_levels = true },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "NONE" },
    },
  })
end

M.use = function()
  vim.g.catppuccin_flavour = "mocha"
  vim.api.nvim_command "colorscheme catppuccin"
end

return M

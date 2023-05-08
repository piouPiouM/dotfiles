local M = {}

M.setup = function()
  require("catppuccin").setup({
    background = {
      light = "latte",
      dark = "mocha",
    },
    term_colors = true,
    integrations = {
      alpha = true,
      barbecue = false,
      cmp = true,
      dashboard = false,
      fidget = true,
      gitsigns = true,
      leap = true,
      lsp_saga = true,
      lsp_trouble = true,
      markdown = true,
      neotree = true,
      nvimtree = false,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      ts_rainbow = false,
      ts_rainbow2 = false,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = false },
    },
  })
end

M.use = function()
  vim.api.nvim_command "colorscheme catppuccin"
end

return M

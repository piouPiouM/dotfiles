local M = {}

M.config = {
  filetypes = { "astro", "css", "scss", "less", "vue", "typescriptreact", "javascriptreact" },
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
      autoFixOnSave = true,
    },
  },
}

return M

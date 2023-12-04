local M = {}

M.config = {
  filetypes = { "astro", "css", "scss", "less" },
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
      autoFixOnSave = true,
    },
  },
}

return M

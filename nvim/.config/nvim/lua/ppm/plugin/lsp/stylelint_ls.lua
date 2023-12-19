local A = require("ppm.toolkit.fp.Array")
local F = require("ppm.toolkit.fp.function")
local ft = require("ppm.filetype")
local M = {}

M.config = {
  filetypes = F.pipe(
    { "astro", "css", "scss", "less", "vue" },
    A.append(ft.typescript)
  ),
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
      autoFixOnSave = true,
    },
  },
}

return M

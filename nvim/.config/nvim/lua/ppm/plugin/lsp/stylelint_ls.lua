local A = require("ppm.toolkit.fp.Array")
local F = require("ppm.toolkit.fp.function")
local ft = require("ppm.filetype")
local M = {}

M.config = {
  filetypes = F.pipe(
    { "astro", "css", "scss", "less", "vue" },
    A.concat(ft.typescript)
  ),
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
      autoFixOnSave = true,
      cssInJs = true,
      unknownAtRules = false,
    },
  },
}

return M

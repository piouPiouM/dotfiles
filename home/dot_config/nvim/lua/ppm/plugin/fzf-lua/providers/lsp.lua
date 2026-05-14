local F = require("ppm.toolkit.fp")
local decorate = require("ppm.plugin.fzf-lua.decorators")
local pipe = F.pipe

local M = {}

M.lsp = {
  finder = {
    providers = {},
  }
}

M.lsp.finder.providers.references = pipe(
  {},
  decorate.with_title("LSP References"),
  decorate.with_theme("fullscreen")
)

return M

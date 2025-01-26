local F = require("ppm.toolkit.fp")
local icons = require("ppm.ui").icons
local decorate = require("ppm.plugin.fzf-lua.decorators")

local pipe = F.pipe

local M = {}

M.complete_file = pipe(
  { prompt = icons.search .. " " },
  decorate.with_title("Insert file exlcuding directories"),
  decorate.disable_preview(),
  decorate.with_theme("cursor")
)

return M

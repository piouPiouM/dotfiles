local F = require("ppm.toolkit.fp")
local ui = require("ppm.ui")
local decorate = require("ppm.plugin.fzf-lua.decorators")

local pipe = F.pipe
local icons = ui.icons

local M = {}

M.lines = pipe(
  { prompt = icons.search .. " " },
  decorate.with_title("Find Lines"),
  decorate.with_theme("vertical"),
  decorate.disable_preview()
)

return M

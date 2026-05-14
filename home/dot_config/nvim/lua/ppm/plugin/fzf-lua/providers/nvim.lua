local F = require("ppm.toolkit.fp")
local ui = require("ppm.ui")
local decorate = require("ppm.plugin.fzf-lua.decorators")

local pipe = F.pipe
local icons = ui.icons

local M = {}

M.command_history = pipe(
  { prompt = icons.terminal .. " " },
  decorate.with_theme("ivy"),
  decorate.with_title("Command history")
)

M.search_history = pipe(
  { prompt = icons.terminal .. " " },
  decorate.with_theme("ivy"),
  decorate.with_title("Search history")
)

M.registers = pipe(
  {},
  decorate.with_theme("sidebar_right")
)

M.keymaps = pipe(
  {
    prompt = icons.search .. " ",
    no_action_zz = true,
  },
  decorate.with_title("Key Maps"),
  decorate.with_theme("ivy")
)

M.helptags = pipe(
  {},
  decorate.with_theme("fullscreen")
)

M.spell_suggest = pipe(
  { prompt = icons.search .. " " },
  decorate.with_title("Spell suggestions"),
  decorate.with_theme("cursor")
)

return M

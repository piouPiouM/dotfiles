local F = require("ppm.toolkit.fp")
local icons = require("ppm.ui").icons
local decorate = require("ppm.plugin.fzf-lua.decorators")

local pipe = F.pipe

local M = {}

M.files = pipe(
  {
    git_icons  = false,
    prompt     = icons.search .. " ",
    cwd_prompt = false,
    rg_opts    = "--color=never --files --hidden --follow",
    fd_opts    = "--color=never --type f --type l --hidden --follow --exclude .git",
  },
  decorate.with_title("Find Files"),
  decorate.with_history("files"),
  decorate.with_theme("ivy")
)

M.oldfiles = pipe(
  { prompt = icons.search .. " " },
  decorate.with_title("History"),
  decorate.with_history("files"),
  decorate.with_theme("ivy")
)

return M
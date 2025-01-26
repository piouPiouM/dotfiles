local F = require("ppm.toolkit.fp")
local ui = require("ppm.ui")
local decorate = require("ppm.plugin.fzf-lua.decorators")

local pipe = F.pipe
local icons = ui.icons

local M = {
  git = {
    icons = {
      ["M"] = { icon = icons.diff_modified },
      ["D"] = { icon = icons.diff_removed },
      ["A"] = { icon = icons.diff_added },
      ["R"] = { icon = icons.diff_renamed },
      -- ["C"] = { icon = "C"},
      -- ["T"] = { icon = "T"},
      -- ["?"] = { icon = "?"},
    },
  },
}


M.git.blame = pipe({}, decorate.with_theme("up"))

M.git.files = pipe(
  {
    prompt = icons.search .. " ",
    rg_opts = [[--color=never --files --hidden --follow]],
    fd_otps = [[--color=never --type f --type l --hidden --follow --exclude .git]],
  },
  decorate.with_title("Git files"),
  decorate.with_history("files"),
  decorate.with_theme("ivy")
)

M.git.commits = pipe(
  { prompt = icons.history .. " " },
  decorate.with_title("Git commits"),
  decorate.with_theme("vertical")
)

M.git.bcommits = pipe(
  { prompt = icons.history .. " " },
  decorate.with_theme("vertical"),
  decorate.with_title("Git commits of current buffer")
)

return M
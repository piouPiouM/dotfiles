local fp = require("ppm.toolkit.fp")
local ui = require("ppm.ui")
local decorate = require("ppm.plugin.fzf-lua.decorators")

local icons = ui.icons
local with_theme, with_title, with_history = decorate.with_theme, decorate.with_title, decorate.with_history

local M = {}

M.command_history = fp.pipe(
  { prompt = icons.terminal .. " " },
  with_theme("ivy"), with_title("Command history")
)

M.search_history = fp.pipe(
  { prompt = icons.terminal .. " " },
  with_theme("ivy"), with_title("Search history")
)

M.complete_file = fp.pipe(
  { prompt = icons.search .. " ", },
  with_theme("cursor"), with_title("Insert filepath")
)

M.registers = fp.pipe(
  {},
  with_theme("sidebar_right")
)

M.files = fp.pipe(
  {
    git_icons = false,
    prompt = icons.search .. " ",
  },
  with_title("Find Files"),
  with_history("files"),
  with_theme("ivy")
)

M.lines = fp.pipe(
  { prompt = icons.search .. " " },
  with_title("Find Lines"), with_theme("vertical")
)

M.oldfiles = fp.pipe(
  { prompt = icons.search .. " " },
  with_title("History"),
  with_history("files"),
  with_theme("ivy")
)

M.git = {
  files = fp.pipe(
    { prompt = icons.search .. " " },
    with_title("Git files"),
    with_history("files"),
    with_theme("ivy")
  ),
  commits = fp.pipe(
    { prompt = icons.history .. " " },
    with_title("Git commits"), with_theme("vertical")
  ),
  bcommits = fp.pipe(
    { prompt = icons.history .. " " },
    with_theme("vertical"), with_title("Git commits of current buffer")
  ),
  icons = {
    ["M"] = { icon = icons.diff_modified },
    ["D"] = { icon = icons.diff_removed },
    ["A"] = { icon = icons.diff_added },
    ["R"] = { icon = icons.diff_renamed },
    -- ["C"] = { icon = "C"},
    -- ["T"] = { icon = "T"},
    -- ["?"] = { icon = "?"},
  },
}

M.grep = fp.pipe({
  rg_glob = true,
  -- Add support for all arguments passed to rg after the separator ` --`.
  -- @example
  --   fzf -- -tzsh
  rg_glob_fn = function(query, opts)
    local search_query, glob_str = query:match("(.*)" .. opts.glob_separator .. "(.*)")
    local glob_args = glob_str:gsub("^%s+", ""):gsub("-", "%-") .. " "

    return search_query, glob_args
  end,
}, with_history("grep"), with_theme("ivy"))

M.keymaps = fp.pipe(
  {
    prompt = icons.search .. " ",
    no_action_zz = true,
  },
  with_title("Key Maps"),
  with_theme("ivy")
)

M.spell_suggest = fp.pipe(
  { prompt = icons.search .. " " },
  with_title("Spell suggestions"), with_theme("cursor")
)

return M
local fp = require("moses")
local ui = require("ppm.ui")
local with_theme = require("ppm.plugin.fzf-lua.theme").with_theme
local decorate = require("ppm.plugin.fzf-lua.decorators")

local M = { providers = {} }

M.providers.command_history = fp.pipe({ prompt = "  " }, with_theme("ivy"), decorate.with_title("Command history"))

M.providers.search_history = fp.pipe({ prompt = "  " }, with_theme("ivy"), decorate.with_title("Search history"))

M.providers.complete_file = fp.pipe({
  prompt = ui.icons.search .. " ",
  winopts = { title = decorate.title("Insert filepath") },
}, with_theme("cursor"))

M.providers.registers = with_theme("sidebar_right")

M.providers.files = fp.pipe({
  git_icons = false,
  prompt = ui.icons.search .. " ",
  winopts = { title = decorate.title("Find Files") },
}, decorate.with_history("files"), with_theme("ivy"))

M.providers.lines = fp.pipe({
  prompt = ui.icons.search .. " ",
  winopts = { title = decorate.title("Find Lines") },
}, with_theme("vertical"))

M.providers.oldfiles = fp.pipe({
  prompt = ui.icons.search .. " ",
  winopts = { title = decorate.title("History") },
}, decorate.with_history("files"), with_theme("ivy"))

M.providers.git = {
  files = fp.pipe({
    prompt = ui.icons.search .. " ",
    winopts = { title = decorate.title("Git files") },
  }, decorate.with_history("files"), with_theme("ivy")),
  commits = fp.pipe({ prompt = "  ", winopts = { title = decorate.title("Git commits") } }, with_theme("vertical")),
  bcommits = fp.pipe({
    prompt = "  ",
    winopts = { title = decorate.title("Git commits of current buffer") },
  }, with_theme("vertical")),
  icons = {
    ["M"] = { icon = ui.icons.diff_modified },
    ["D"] = { icon = ui.icons.diff_removed },
    ["A"] = { icon = ui.icons.diff_added },
    ["R"] = { icon = ui.icons.diff_renamed },
    -- ["C"] = { icon = "C"},
    -- ["T"] = { icon = "T"},
    -- ["?"] = { icon = "?"},
  },
}

M.providers.grep = fp.pipe({
  rg_glob = true,
  -- Add support for all arguments passed to rg after the separator ` --`.
  -- @example
  --   fzf -- -tzsh
  rg_glob_fn = function(query, opts)
    local search_query, glob_str = query:match("(.*)" .. opts.glob_separator .. "(.*)")
    local glob_args = glob_str:gsub("^%s+", ""):gsub("-", "%-") .. " "

    return search_query, glob_args
  end,
}, decorate.with_history("grep"), with_theme("ivy"))

M.providers.keymaps = fp.pipe({
  prompt = ui.icons.search .. " ",
  no_action_zz = true,
  winopts = { title = decorate.title("Key Maps") },
}, with_theme("ivy"))

M.providers.spell_suggest = fp.pipe({
  prompt = ui.icons.search .. " ",
  winopts = { title = decorate.title("Spell suggestions") },
}, with_theme("cursor"))

local config = {
  "telescope",
  global_git_icons = true,
  global_resume = true,
  global_resume_query = true,
  file_icon_padding = vim.env.TERM == "xterm-kitty" and " " or "",
  fzf_opts = { ["--no-separator"] = "" },
  winopts = { title = "", title_pos = "center" },
  previewers = {
    builtin = {
      extensions = {
        -- neovim terminal only supports `viu` block output
        ["gif"] = { "viu", "-t" },
        ["jpg"] = { "viu", "-t" },
        ["png"] = { "viu", "-t" },
      },
    },
  },
  keymap = { builtin = { ["?"] = "toggle-preview" } },
}

require("fzf-lua").setup(vim.tbl_deep_extend("force", config, M.providers))

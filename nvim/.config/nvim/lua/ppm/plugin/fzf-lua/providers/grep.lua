local F = require("ppm.toolkit.fp")
local decorate = require("ppm.plugin.fzf-lua.decorators")
local icons = require("ppm.ui").icons

local pipe = F.pipe

local M = {}

M.grep = pipe({
    prompt = icons.rg .. " ",
    rg_glob = true,
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
    ---Add support for all arguments passed to rg after the separator ` --`.
    ---@example
    ---  fzf -- -tzsh
    rg_glob_fn = function(query, opts)
      local search_query, glob_str = query:match("(.*)" .. opts.glob_separator .. "(.*)")
      local glob_args = glob_str:gsub("^%s+", ""):gsub("-", "%-") .. " "

      return search_query, glob_args
    end,
  },
  decorate.with_title("Search in files"),
  decorate.with_history("grep"),
  decorate.with_theme("fullscreen")
)

return M

local fn = vim.fn
local actions = require "fzf-lua.actions"
local complete = require "fzf-lua.complete"
local config = require "fzf-lua.config"
local utils = require "fzf-lua.utils"

local M = {}

local source = fn.expand("$XDG_DATA_HOME/$USER/symbols/nerdfonts.json")

local insert_symbol = function(selected, opts)
  local symbol = fn.split(selected[1])[1]

  actions.complete_insert({ symbol }, opts)
end

local defaults = {
  cmd = "jq -r '.[] | join(\" \")' " .. source,
  actions = { ["default"] = insert_symbol },
  fn_transform = function(x)
    local glyth, name = x:match("^(.*)%s(.*)$")
    return string.format("%s  %s", utils.ansi_codes.magenta(glyth), name)
  end,
}

M.complete_symbol = function(opts)
  opts = config.normalize_opts(opts, defaults)
  if not opts then return end

  local pk_cursor = require("ppm.toolkit.cursor")
  opts.query = opts.query or pk_cursor.get_previous_word() or fn.expand("<cWORD>")

  complete.fzf_complete(opts.cmd, opts)
end

return M

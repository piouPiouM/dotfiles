local fn = vim.fn
local fp = require("moses")
local Path = require("plenary.path")
local config = require("fzf-lua.config")
local complete = require("fzf-lua.complete")
local core = require("fzf-lua.core")
local utils = require("fzf-lua.utils")
local actions = require("ppm.plugin.fzf-lua.actions")
local decorate = require("ppm.plugin.fzf-lua.decorators")
local with_theme = require("ppm.plugin.fzf-lua.theme").with_theme

local M = { actions = {} }

local global_defaults = fp.pipe({}, decorate.with_title(" Nerd Fonts"), decorate.with_history("nf"))

local function read_source()
  local source = fn.expand("$XDG_DATA_HOME/$USER/symbols/nerdfonts.json")
  local max_width = 0
  local data = {}
  local json = {}
  json = vim.json.decode(Path:new(source):read())

  if json then
    max_width = json.METADATA["max-length"] + 3 or -1

    for _, entry in ipairs(json.glyths) do
      table.insert(data, string.format("%s  %s", utils.ansi_codes.magenta(entry[1]), entry[2]))
    end
  end

  return data, max_width
end

local function set_query(opts)
  local pk_cursor = require("ppm.toolkit.cursor")
  opts.query = opts.query or pk_cursor.get_previous_word() or fn.expand("<cword>")

  return opts
end

local function normalize_opts(opts, ...) return config.normalize_opts(opts, vim.tbl_deep_extend("force", ...)) end

function M.symbol(opts)
  local defaults = {
    actions = {
      default = function(selected)
        local symbol = fn.split(selected[1])[1]

        actions.paste(symbol)
      end,
    },
  }

  opts = normalize_opts(opts, global_defaults, defaults)
  if not opts then return end

  local data = read_source()
  core.fzf_exec(data, set_query(opts))
end

function M.complete_symbol(opts)
  local data, content_width = read_source()
  local defaults = fp.pipe({
    content_width = content_width,
    actions = {
      default = function(selected, ...)
        local symbol = fn.split(selected[1])[1]

        actions.insert(symbol, ...)
      end,
    },
  }, with_theme("cursor"))

  opts = normalize_opts(opts, global_defaults, defaults)
  if not opts then return end

  complete.fzf_complete(data, set_query(opts))
end

return M

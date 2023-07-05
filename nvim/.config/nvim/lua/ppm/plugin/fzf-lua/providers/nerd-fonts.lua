local fn = vim.fn
local Path = require("plenary.path")
local config = require("fzf-lua.config")
local complete = require("fzf-lua.complete")
local core = require("fzf-lua.core")
local utils = require("fzf-lua.utils")
local fp = require("ppm.toolkit.fp")
local A = require("ppm.toolkit.fp.Array")
local str = require("ppm.toolkit.string")
local ui = require("ppm.ui")
local actions = require("ppm.plugin.fzf-lua.actions")
local decorate = require("ppm.plugin.fzf-lua.decorators")

local M = { actions = {} }

local global_defaults = fp.pipe(
  {},
  decorate.with_title(" Nerd Fonts"),
  decorate.with_history("nf")
)

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

local function parse_selected(selected, glue)
  local first_word = fp.compose(A.head, str.words)

  return fp.pipe(
    A.map(selected, first_word),
    A.concat(glue)
  ) .. glue
end

function M.symbol(opts)
  local defaults = fp.pipe({
    actions = {
      default = function(selected)
        actions.paste(parse_selected(selected, ui.icon_padding))
      end,
    },
  }, decorate.with_theme("sidebar_right"))

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
        actions.insert(parse_selected(selected, ui.icon_padding), ...)
      end,
    },
  }, decorate.with_theme("cursor"))

  opts = normalize_opts(opts, global_defaults, defaults)
  if not opts then return end

  complete.fzf_complete(data, set_query(opts))
end

return M

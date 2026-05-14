local fn       = vim.fn
local Path     = require("plenary.path")
local config   = require("fzf-lua.config")
local complete = require("fzf-lua.complete")
local core     = require("fzf-lua.core")
local utils    = require("fzf-lua.utils")
local F        = require("ppm.toolkit.fp")
local O        = require("ppm.toolkit.fp.Option")
local ui       = require("ppm.ui")
local actions  = require("ppm.plugin.fzf-lua.actions")
local decorate = require("ppm.plugin.fzf-lua.decorators")
local helpers  = require("ppm.plugin.fzf-lua.helpers")
local IOEither = require("ppm.toolkit.fp.IOEither")
local pipe     = F.pipe
local M        = { actions = {} }

local function read_source()
  local source = fn.expand("$XDG_DATA_HOME/$USER/symbols/nerdfonts.json")
  local max_width = 0
  local data = {}
  local json = IOEither.try_catch(
    function()
      return vim.json.decode(Path:new(source):read())
    end,
    F.identity
  )

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

local function normalize_opts(opts, ...)
  return O.fromNullable(config.normalize_opts(opts, vim.tbl_deep_extend("force", ...)))
end

local parse_selected = helpers.join_first_words(ui.icon_padding)

local global_defaults = pipe(
  {},
  decorate.with_title(" Nerd Fonts"),
  decorate.with_history("nf")
)

function M.symbol(opts)
  local data = read_source()
  local defaults = pipe({
    actions = {
      default = function(selected)
        actions.paste(parse_selected(selected))
      end,
    },
  }, decorate.with_theme("sidebar_right"))

  pipe(
    normalize_opts(opts, global_defaults, defaults),
    O.map(set_query),
    O.match(
      F.noop,
      helpers.exec(core.fzf_exec, data)
    )
  )
end

function M.complete_symbol(opts)
  local data, content_width = read_source()
  local defaults = pipe({
    content_width = content_width,
    actions = {
      default = function(selected, ...)
        actions.insert(parse_selected(selected), ...)
      end,
    },
  }, decorate.with_theme("cursor"))

  pipe(
    normalize_opts(opts, global_defaults, defaults),
    O.map(set_query),
    O.match(
      F.noop,
      helpers.exec(complete.fzf_complete, data)
    )
  )
end

return M

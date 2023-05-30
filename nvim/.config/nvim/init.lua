pcall(require, "impatient")

local api = vim.api
local g = vim.g
local o = vim.o
local cmd = vim.cmd
local fn = vim.fn

o.encoding = "utf-8"
o.fileencoding = "utf-8"

g.mapleader = " "
g.maplocalleader = "ù"

-- To avoid to memorize my final choice
g.snippets = "luasnip"

-- Support embedded lua
g.vimsyn_embed = "l"

-- Configure providers to make startup faster {{{
-- See https://neovim.io/doc/user/provider.html
g.node_host_prog = "/usr/local/bin/neovim-node-host"

if fn.has("macunix") then
  g.python_host_prog = "/usr/local/bin/python2"
  g.python3_host_prog = "/usr/local/bin/python3"
  g.ruby_host_prog = vim.fn.expand("~/.gem/ruby/2.6.0/bin/neovim-ruby-host")
else
  g.python3_host_prog = "/usr/bin/python"
end

-- }}}

cmd [[
  runtime! lua/ppm/setup/globals.lua
  runtime! lua/ppm/setup/disable-builtin.lua
  runtime! lua/ppm/setup/options.lua
]]

require("ppm.plugin")

cmd [[syntax enable]]

local config_file = vim.fn.expand('~/.theme')

if vim.fn.filereadable(config_file) then
  local background, scheme = unpack(vim.fn.readfile(config_file, '', 2))
  o.background = background
else
  o.background = "dark"
end

require("ppm.colorscheme.catppuccin").use()

-- Lazy load plugins using a custom autocmd `User ActuallyEditing` {{{

local autocmd = vim.api.nvim_create_autocmd
local group_id = vim.api.nvim_create_augroup("lazyLoading", { clear = true })
local function emitActuallyEditingEvent()
  api.nvim_exec_autocmds("User", { pattern = "ActuallyEditing" })
end

autocmd("BufReadPre", {
  group = group_id,
  pattern = "*",
  once = true,
  callback = function()
    if fn.argc() ~= 0 or fn.line2byte(fn.line("$")) ~= -1 or o.insertmode then
      emitActuallyEditingEvent()
    end
  end,
})

autocmd("User", {
  group = group_id,
  pattern = "AlphaClosed",
  once = true,
  callback = emitActuallyEditingEvent,
})

-- }}}

local api = vim.api
local g = vim.g
local o = vim.o
local cmd = vim.cmd
local fn = vim.fn

o.encoding = "utf-8"
o.fileencoding = "utf-8"

g.mapleader = " "
g.maplocalleader = "ù"

-- Enable builtin support of `.editorconfig` files
g.editorconfig = true

-- To avoid to memorize my final choice
g.snippets = "luasnip"

-- Support embedded lua
g.vimsyn_embed = "l"

-- Configure providers to make startup faster {{{
-- See https://neovim.io/doc/user/provider.html
g.node_host_prog = "/usr/local/bin/neovim-node-host"

if fn.has("macunix") == 1 then
  g.python_host_prog = "/usr/local/bin/python2"
  g.python3_host_prog = "/usr/local/bin/python3"
else
  g.python_host_prog = "/usr/bin/python2"
  g.python3_host_prog = "/usr/bin/python"
end

-- }}}

cmd [[
  runtime! lua/ppm/setup/globals.lua
  runtime! lua/ppm/setup/options.lua
]]

require("ppm.plugin.lazy")

cmd [[syntax enable]]

-- if filereadable(expand("$HOME/.local/vimrc")) then
--   source $HOME/.local/vimrc
-- end

-- if filereadable(expand("$XDG_DATA_HOME/nvim/init.vim")) then
--   source $XDG_DATA_HOME/nvim/init.vim
-- end

if fn.filereadable(fn.expand("$HOME/.theme")) then
  local mode = unpack(fn.readfile(fn.expand("$HOME/.theme"), nil, 1))
  o.background = mode or "dark"
else
  o.background = "dark"
end


-- Lazy load plugins using a custom autocmd `User ActuallyEditing` {{{

local autocmd = vim.api.nvim_create_autocmd
local group_id = vim.api.nvim_create_augroup("lazyLoading", { clear = true })
local function emitActuallyEditingEvent()
  api.nvim_exec_autocmds("User", {
    pattern = "ActuallyEditing",
  })
end

autocmd("BufReadPre", {
  group = group_id,
  pattern = "*",
  once = true,
  callback = function()
    if fn.argc() ~= 0 or fn.line2byte(fn.line("$")) ~= -1 or o.insertmode then emitActuallyEditingEvent() end
  end,
})

autocmd("User", {
  group = group_id,
  pattern = "AlphaClosed",
  once = true,
  callback = emitActuallyEditingEvent,
})

-- }}}
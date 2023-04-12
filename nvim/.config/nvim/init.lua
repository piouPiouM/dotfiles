pcall(require, "impatient")

local g = vim.g
local o = vim.o
local cmd = vim.cmd
local fn = vim.fn

require("ppm.setup.globals")

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
--[[ local status, _ = pcall(require, "packer_compiled")
if not status then vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!") end ]]

g.node_host_prog = "/usr/local/bin/neovim-node-host"

if fn.has("macunix") then
  g.python_host_prog = "/usr/local/bin/python2"
  g.python3_host_prog = "/usr/local/bin/python3"
else
  g.python3_host_prog = "/usr/bin/python"
end

-- }}}

require("ppm.plugin")

-- cmd [[source $XDG_CONFIG_HOME/nvim/config/vim-plug.vim]]

cmd [[
  runtime! lua/ppm/setup/disable-builtin.lua
  runtime! lua/ppm/setup/options.lua
]]

cmd [[syntax enable]]

-- if filereadable(expand("$HOME/.local/vimrc")) then
--   source $HOME/.local/vimrc
-- end

-- if filereadable(expand("$XDG_DATA_HOME/nvim/init.vim")) then
--   source $XDG_DATA_HOME/nvim/init.vim
-- end

o.background = "dark"

require("ppm.colorscheme.rose-pine").use()
require("ppm.colorscheme.catppuccin").use()

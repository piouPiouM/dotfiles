require("ppm.globals")

-- enable filetype.lua
vim.g.do_filetype_lua = 1

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.mapleader = " "
vim.g.maplocalleader = "ù"

-- To avoid to memorize my final choice
vim.g.snippets = "luasnip"

-- Support embedded lua
vim.g.vimsyn_embed = "l"

-- Configure providers to make startup faster {{{
-- See https://neovim.io/doc/user/provider.html

vim.g.node_host_prog = "/usr/local/bin/neovim-node-host"

if vim.fn.has("macunix") then
  vim.g.python_host_prog = "/usr/local/bin/python2"
  vim.g.python3_host_prog = "/usr/local/bin/python3"
else
  vim.g.python3_host_prog = "/usr/bin/python"
end

-- }}}

vim.cmd [[
  source $XDG_CONFIG_HOME/nvim/config/vim-plug.vim
  syntax enable
]]

vim.cmd [[
  runtime! lua/ppm/config/disable-builtin.lua
  runtime! lua/ppm/config/options.lua
]]

-- if filereadable(expand("$HOME/.local/vimrc")) then
--   source $HOME/.local/vimrc
-- end

-- if filereadable(expand("$XDG_DATA_HOME/nvim/init.vim")) then
--   source $XDG_DATA_HOME/nvim/init.vim
-- end

vim.opt.diffopt:append { "algorithm:patience" }
vim.opt.background = "dark"

require("colorscheme.nord").setup()
require("colorscheme.nordbuddy").setup()
require("colorscheme.nightfox").setup()
require("colorscheme.catppuccin").setup()
require("colorscheme.catppuccin").set()

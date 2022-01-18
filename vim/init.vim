scriptencoding utf-8

" init.vim
" Author: Mehdi Kabab <http://pioupioum.fr>
" Source: http://github.com/piouPiouM/dotfiles/

set encoding=utf-8
set fileencoding=utf-8

let mapleader=" "
let maplocalleader="ù"
let g:vimsyn_embed = 'l'

if ! has('nvim')
  set nocompatible
  source $XDG_CONFIG_HOME/nvim/config/compat.vim
endif

source $XDG_CONFIG_HOME/nvim/config/vim-plug.vim
syntax enable

source $XDG_CONFIG_HOME/nvim/config/settings.vim

if filereadable(expand("$HOME/.local/vimrc"))
  source $HOME/.local/vimrc
endif
if has('nvim')
  if filereadable(expand("$XDG_DATA_HOME/nvim/init.vim"))
    source $XDG_DATA_HOME/nvim/init.vim
  endif
endif

lua << EOF
vim.opt.background = 'dark'

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_cursorline_transparent = true
vim.g.nord_italic = true
-- require('nord').set()

vim.g.nord_underline_option = 'undercurl'
vim.g.nord_italic = true
vim.g.nord_italic_comments = true
vim.g.nord_minimal_mode = false
-- vim.cmd('colorscheme nordbuddy')

local nightfox = require('nightfox')
nightfox.setup({
  fox = "nordfox",
  alt_nc = true,
})
-- nightfox.load()

local catppuccin = require('catppuccin')
catppuccin.setup {
  term_colors = true,
  integrations = {
    gitgutter = true,
    hop = true,
    lsp_trouble = true,
    markdown = true,
    native_lsp = {
      underlines = {
        errors = 'undercurl',
        hints = 'undercurl',
        warnings = 'undercurl',
        information = 'undercurl',
      },
    },
    telescope = true,
  }
}

vim.cmd[[colorscheme catppuccin]]
EOF

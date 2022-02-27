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

let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/local/bin/python3'
let g:loaded_perl_provider = 0
let g:node_host_prog = '/usr/local/bin/neovim-node-host'

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
vim.opt.diffopt:append { 'algorithm:patience' }
vim.opt.background = 'dark'

require("colorscheme.nord").setup()
require("colorscheme.nordbuddy").setup()
require("colorscheme.nightfox").setup()
require("colorscheme.catppuccin").setup()
require("colorscheme.catppuccin").set()

EOF

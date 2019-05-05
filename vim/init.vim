scriptencoding utf-8

" init.vim
" Author: Mehdi Kabab <http://pioupioum.fr>
" Source: http://github.com/piouPiouM/dotfiles/

set encoding=utf-8
set fileencoding=utf-8

let mapleader=","
let maplocalleader="ù"

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

if globpath(&runtimepath, 'colors/iceberg.vim', 1) !=# ''
  set background=dark
  colorscheme iceberg
else
  set background=light
  colorscheme zellner
  let g:airline_theme='aurora'
endif


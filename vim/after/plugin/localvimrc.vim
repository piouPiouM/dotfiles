if !exists("g:loaded_localvimrc")
  finish
endif

let g:localvimrc_name = ['.git/vimrc', '.lvimrc', '.local.vimrc', '.config/vimrc']
let g:localvimrc_ask = 1
let g:localvimrc_persistent = 1 " Store and restore decisions only for upper case answer (Y/N/A)
let g:localvimrc_persistence_file = $XDG_DATA_HOME . '/nvim/localvimrc_persistent'
let g:localvimrc_sandbox = 0
let g:localvimrc_whitelist = [] " See $HOME/.local/vimrc


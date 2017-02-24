" XDG Environment For VIM
" =======================
"
" References
" ----------
"
" - http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables
" - http://tlvince.com/vim-respect-xdg
" - https://gist.github.com/kaleb/3885679

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = $HOME . '/.cache'
endif
if !isdirectory($XDG_CACHE_HOME . '/vim/swap')
  silent call mkdir($XDG_CACHE_HOME . '/vim/swap', 'p')
endif
if !isdirectory($XDG_CACHE_HOME . '/vim/backup')
  silent call mkdir($XDG_CACHE_HOME . '/vim/backup', 'p')
endif
if !isdirectory($XDG_CACHE_HOME . '/vim/undo')
  silent call mkdir($XDG_CACHE_HOME . '/vim/undo', 'p')
endif

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME . '/.config'
endif
if !isdirectory($XDG_CONFIG_HOME)
  silent call mkdir($XDG_CONFIG_HOME, 'p')
endif

if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = $HOME . '/.local/share'
endif
if !isdirectory($XDG_DATA_HOME)
  silent call mkdir($XDG_DATA_HOME . '/vim', 'p')
endif

set directory=$XDG_CACHE_HOME/vim/swap//,/tmp//
set backupdir=$XDG_CACHE_HOME/vim/backup//,/tmp//
set undodir=$XDG_CACHE_HOME/vim/undo//,/tmp//

" TODO: make vim fully XDG compatible
"set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
"set runtimepath+=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
"let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

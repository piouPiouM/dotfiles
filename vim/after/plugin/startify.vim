if !exists('g:loaded_startify')
  finish
endif

let g:startify_enable_special = 0
let g:startify_session_dir =  $XDG_DATA_HOME . '/nvim/startify-session'
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_fortune_use_unicode = 1
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ ]
let g:startify_bookmarks = [] " See $HOME/.local/vimrc
let g:startify_list_order = [
      \ ['  MRU in the current directory:'],
      \ 'dir',
      \ ['  Recently used files:'],
      \ 'files',
      \ ['  Sessions:'],
      \ 'sessions',
      \ ['  Bookmarks:'],
      \ 'bookmarks',
      \ ['  Commands:'],
      \ 'commands'
      \ ]


" autocommands.vim

if !has("autocmd")
  finish
endif

" Executes a stack of commands when creating windows
augroup enter_cmd
  autocmd!
  autocmd VimEnter * call ppm#exe_vimenter()

  " Set CtrlP window to fit the screen.
  autocmd VimEnter,VimResized * let g:ctrlp_max_height = &lines
augroup END

" Highlight cursorline ONLY in the active window
augroup cursor_line
  autocmd!
  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline
augroup END

" Display trailing whitespace in insert mode only
augroup trailing
  autocmd!
  autocmd InsertEnter * set listchars-=trail:⌴
  autocmd InsertLeave * set listchars+=trail:⌴
augroup END

" Use relative numbers in normal mode when Vim is active
augroup relativenumber
  autocmd!
  autocmd FocusLost * set number
  autocmd FocusGained * set relativenumber
  autocmd InsertEnter * set number
  autocmd InsertLeave * set relativenumber
augroup END

" Source the vimrc file after saving it.
" http://vimcasts.org/e/24
augroup reload_config
  if has("gui_running")
    autocmd! bufwritepost .vimrc source $MYVIMRC
    autocmd! bufwritepost .gvimrc source $MYGVIMRC
  else
    autocmd! bufwritepost .vimrc source $MYVIMRC
  endif
augroup END

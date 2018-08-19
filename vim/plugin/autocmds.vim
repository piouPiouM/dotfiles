" autocommands.vim

if !has("autocmd")
  finish
endif

augroup ft_json
  autocmd!
  autocmd BufReadPost .eslintrc setlocal filetype=json
augroup END

" augroup ft_typescript
"   autocmd!
"   autocmd FileType typescript JsPreTmpl html
" augroup END

" Propose to create nonexistent directories at save.
augroup auto_mkdir
  autocmd!
  autocmd BufWritePre * call ppm#functions#auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" Executes a stack of commands when creating windows
augroup enter_cmd
  autocmd!

  " Set CtrlP window to fit the screen.
  " autocmd VimEnter,VimResized * let g:ctrlp_max_height = &lines
augroup END

" Display trailing whitespace in insert mode only
augroup trailing
  autocmd!
  autocmd InsertEnter * set listchars-=trail:⌴
  autocmd InsertLeave * set listchars+=trail:⌴
augroup END

" let s:ft_to_ignore = ['nerdtree', 'fzf']
" augroup relativenumber_toggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * if index(s:ft_to_ignore, &filetype) < 0 | setlocal relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * if index(s:ft_to_ignore, &filetype) < 0 | setlocal norelativenumber
" augroup END


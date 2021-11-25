" autocommands.vim

if !has("autocmd")
  finish
endif

augroup ft_json
  autocmd!
  autocmd BufReadPost .eslintrc setlocal filetype=json
augroup END

" Propose to create nonexistent directories at save.
augroup auto_mkdir
  autocmd!
  autocmd BufWritePre * call ppm#functions#auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" Display trailing whitespace in insert mode only
augroup trailing
  autocmd!
  autocmd InsertEnter * set listchars-=trail:⌴
  autocmd InsertLeave * set listchars+=trail:⌴
augroup END

" Disable numbers for specific filetypes
let s:ft_number_disabled = ['nerdtree', 'fzf']
augroup disable_number
  autocmd!
  autocmd BufEnter,FocusGained * if index(s:ft_number_disabled, &filetype) >= 0 | setlocal nonumber
augroup END

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 800 }
augroup END

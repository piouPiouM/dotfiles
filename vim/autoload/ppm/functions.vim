" ppm#functions#echowarn: display a warning message {{{ "
function! ppm#functions#echowarn(msg) abort
  try
    echohl WarningMsg
    echomsg a:msg
  finally
    echohl None
  endtry

  return 0
endfunction
" }}} ppm#functions#echowarn "

" ppm#functions#echoerr: display an error message {{{ "
function! ppm#functions#echoerr(msg) abort
  try
    echohl ErrorMsg
    echomsg a:msg
  finally
    echohl None
  endtry

  return 0
endfunction
" }}} ppm#functions#echoerr "

" ppm#functions#plug_gx: if exists, open github repository under the cursor in browser {{{ "
function! ppm#functions#plug_gx()
  let cfile = expand('<cfile>')
  let fname = expand(exists("g:netrw_gx") ? g:netrw_gx : cfile)

  if getline('.') =~ '^Plug\s'
    if cfile !~ 'github\.com' && !filereadable(cfile)
      let fname = printf('https://github.com/%s', cfile)
    endif
  endif

  call netrw#BrowseX(fname, netrw#CheckIfRemote())
endfunction
" }}} ppm#functions#plug_g "

" ppm#functions#auto_mkdir: saving files in nonexistent directories {{{ "
"
" Thx to http://travisjeffery.com/b/2011/11/saving-files-in-nonexistent-directories-with-vim/
function! ppm#functions#auto_mkdir(dir, force)
  if !isdirectory(a:dir)
        \   && (a:force
        \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
    call mkdir(a:dir, 'p')
  endif
endfunction
" }}} ppm#functions#auto_mkdir "


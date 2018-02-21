function! ppm#functions#echowarn(msg) abort
  try
    echohl WarningMsg
    echomsg a:msg
  finally
    echohl None
  endtry

  return 0
endfunction

function! ppm#functions#echoerr(msg) abort
  try
    echohl ErrorMsg
    echomsg a:msg
  finally
    echohl None
  endtry

  return 0
endfunction

" ppm#functions#plug_gx: if exists, open github repository under the cursor in browser {{{1
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


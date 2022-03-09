
function! ppm#log(msg, ...)
  let msg = '[ppm] ' . a:msg
  if exists(a:0) && a:0 ==? 'error'
    echoerr msg
  else
    echom msg
  endif
endfunction

function! ppm#source(file)
  let file_to_source = g:ppm_vim_path . '/' . a:file
  if !filereadable(file_to_source)
    call ppm#log("The file `" . file_to_source . "` is unreadable.", 'error')
    return 0
  endif
  exe 'source ' . file_to_source
endfunction

function! ppm#mkdir(dir, flags, ...)
  let dir = expand(a:dir)
  if !isdirectory(dir)
    let permission = 0755
    if a:0 == 3
      let permission = a:3
    endif
    call mkdir(dir, a:flags, permission)
  endif
endfunction

function! ppm#disable_plugin(name, ...)
  return 1
endfunction

function! ppm#is_plugin_loaded(name)
  return 1
endfunction

function! ppm#do_after_plugin(method, ...)
  if !exists("g:ppm_after_plugins")
    let g:ppm_after_plugins = []
  endif
  " Si les plugins listés sont chargés on stocke func
  " sinon on écrit un message de log indiquant quelle
  " dépendance fait défaut.
  call add(g:ppm_after_plugins, a:method)
endfunction

function! ppm#exe_vimenter()
  if exists("g:ppm_after_plugins") && len(g:ppm_after_plugins) > 0
    for method in g:ppm_after_plugins
      execute 'call ' . method . '()'
    endfor
  endif
endfunction


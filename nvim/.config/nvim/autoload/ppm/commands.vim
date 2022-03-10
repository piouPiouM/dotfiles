" Change directory to the root of the Git repository.
function! ppm#commands#root() abort
  let root = systemlist('git rev-parse --show-toplevel')[0]

  if v:shell_error
    call ppm#functions#echoerr('Not in git repo')
  else
    execute 'lcd' root
    echo 'Changed directory to: '. root
  endif
endfunction


" An action can be a reference to a function that processes selected lines
function! ppm#fzf#build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" ------------------------------------------------------------------
" Files with preview
" ------------------------------------------------------------------
function! ppm#fzf#files(args, bang)
  return fzf#vim#files(a:args, s:fzf_preview(a:bang) , a:bang)
endfunction

" ------------------------------------------------------------------
" Ripgrep
" ------------------------------------------------------------------
function! ppm#fzf#rg(args, bang)
  if !executable('rg')
    return ppm#functions#echowarn('rg is not found')
  endif

  let tokens  = split(a:args)
  let rg_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  let command = get(g:, 'rg_command', 'rg --line-number --no-messages --no-heading')
  let command = printf('%s %s %s', command, rg_opts, fzf#shellescape(query))
  let fzf_opts = {'options': ['--query=' . query]}

  return call('fzf#vim#grep',
        \ [command, 1, s:fzf_preview(fzf_opts, a:bang), a:bang]
        \ )
endfunction

" ------------------------------------------------------------------
" Spotlight
" ------------------------------------------------------------------
function! ppm#fzf#spotlight(args, bang)
  if !executable('mdfind')
    return ppm#functions#echowarn('mdfind is not found')
  endif

  let wrapped = fzf#wrap('spotlight', {
        \ 'source'  : 'mdfind ' . a:args,
        \ 'options' : '-m --prompt "Spotlight> "'
        \ }, a:bang)

  return fzf#run(s:fzf_preview(wrapped, a:bang))
endfunction

" ------------------------------------------------------------------
" GModified
" ------------------------------------------------------------------
function! ppm#fzf#git_modified(args, bang)
  let wrapped = fzf#wrap('gmodified', {
        \ 'source': 'git ls-files --exclude-standard --modified',
        \ })

  return fzf#run(s:fzf_preview(wrapped, a:bang))
endfunction

" ------------------------------------------------------------------
" [[options], bang, [toggle-preview keys]]
function! s:fzf_preview(...)
  let options = {}
  let args    = copy(a:000)
  let bang    = 0
  let toggle_key = '?'

  if len(args) && type(args[0]) == v:t_dict
    let options = copy(args[0])
    call remove(args, 0)
  endif

  if len(args) && type(args[0]) == v:t_number
    let bang = copy(args[0])
    call remove(args, 0)
  endif

  if len(args)
    let toggle_key = copy(args[0])
  endif

  return fzf#vim#with_preview(options, bang ? 'up:60%' : 'right:70%:hidden', toggle_key)
endfunction


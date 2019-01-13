" Make the search terms less aggressive.
function s:UnderlineSearchGroup()
  let l:color=pinnacle#extract_bg('Search')
  let l:highlight=pinnacle#highlight({
        \ 'bg': 'NONE',
        \ 'fg': l:color,
        \ 'term': 'underline,italic'
        \ })
  execute 'highlight Search ' . l:highlight
endfunction

function! s:AfterColors()
  if exists('g:colors_name') && strlen(g:colors_name)
    execute 'runtime! after/colors/' . g:colors_name . '.vim'
  endif
endfunction

if v:progname !=# 'vi'
  if has('autocmd')
    augroup PpmColors
      autocmd!
      autocmd VimEnter,ColorScheme * call s:AfterColors()
      autocmd VimEnter,ColorScheme * silent! call s:UnderlineSearchGroup()
    augroup END
  endif
endif


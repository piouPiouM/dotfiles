" Makes the words found less aggressive.
function s:UnderlineSearchGroup()
  let l:color=pinnacle#extract_bg('Search')
  let l:highlight=pinnacle#highlight({'bg': 'NONE', 'fg': l:color, 'term': 'underline'})
  execute 'highlight Search ' . l:highlight
endfunction

if v:progname !=# 'vi'
  if has('autocmd')
    augroup PioupioumUnderlineSearchGroup
      autocmd!
      autocmd colorscheme * call s:UnderlineSearchGroup()
    augroup END
  endif

  call s:UnderlineSearchGroup()
endif

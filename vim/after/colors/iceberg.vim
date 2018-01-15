" Remove background for better experience with vim-diminactive
hi! NonText ctermbg=NONE ctermfg=236 guibg=NONE guifg=#242940
hi! ColorColumn cterm=NONE ctermbg=235 guibg=#1e2132

hi! String ctermfg=224 guifg=#ceb0b6
hi! Conceal ctermfg=237 guifg=#2a3158
hi! link elmDelimiter elmOperator

" Custom Ale support
hi! ALEError cterm=underline ctermfg=203 ctermbg=235 gui=undercurl guifg=#e27878 guibg=#1e2132
hi! ALEWarning cterm=underline ctermfg=150 ctermbg=235 gui=undercurl guifg=#d8e599 guibg=#1e2132

" Force IndentLine to use my custom Conceal colors.
let g:indentLine_color_term=237
let g:indentLine_color_gui="#2a3158"

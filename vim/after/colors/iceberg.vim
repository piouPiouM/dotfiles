hi! String ctermfg=224 guifg=#ceb0b6
hi! Conceal ctermfg=237 guifg=#2a3158
hi! link elmDelimiter elmOperator

" Adds support of Neomake
" TODO: create a pull-request.
hi! NeomakeWarningSignDefault ctermfg=150 ctermbg=235 guifg=#d8e599 guibg=#1e2132
hi! NeomakeWarningSign ctermfg=150 ctermbg=235 guifg=#d8e599 guibg=#1e2132
hi! NeomakeErrorSignDefault ctermfg=203 ctermbg=235 guifg=#e27878 guibg=#1e2132
hi! NeomakeErrorSign ctermfg=203 ctermbg=235 guifg=#e27878 guibg=#1e2132
hi! NeomakeWarningDefault cterm=underline ctermfg=150 ctermbg=235 gui=undercurl guifg=#d8e599 guibg=#1e2132
hi! NeomakeWarning cterm=underline ctermfg=150 ctermbg=235 gui=undercurl guifg=#d8e599 guibg=#1e2132
hi! NeomakeErrorDefault cterm=underline ctermfg=203 ctermbg=235 gui=undercurl guifg=#e27878 guibg=#1e2132
hi! NeomakeError cterm=underline ctermfg=203 ctermbg=235 gui=undercurl guifg=#e27878 guibg=#1e2132

" Force IndentLine to use my custom Conceal colors.
let g:indentLine_color_term=237
let g:indentLine_color_gui="#2a3158"

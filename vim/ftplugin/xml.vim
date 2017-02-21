autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

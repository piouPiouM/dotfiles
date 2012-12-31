" filetypes.vim

" Section: CSS, Sass, SCSS and LessCSS {{{1
" ------------------------------------

augroup ft_css
  autocmd!
  autocmd FileType css,less,sass,scss setlocal foldmethod=marker foldmarker={,} nofoldenable
  autocmd FileType css,less,sass,scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType css,less,sass,scss setlocal expandtab
  autocmd FileType css,sass,scss      setlocal omnifunc=csscomplete#CompleteCSS
augroup END

" }}}1
" Section: HTML {{{1
" -------------

augroup ft_html
  autocmd!
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
augroup END

" }}}1
" Section: JavaScript {{{1
" -------------------

augroup ft_js
  autocmd!
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END

" }}}1
" Section: Markdown {{{1
" -----------------

augroup ft_markdown
  autocmd!
  autocmd FileType markdown setlocal wrap linebreak
  autocmd FileType markdown setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType markdown setlocal textwidth=120
  autocmd FileType markdown setlocal colorcolumn=+1
  autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
augroup END

" }}}1
" Section: PHP {{{1
" ------------

augroup ft_php
  autocmd!
  autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType php setlocal expandtab
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup END

" }}}1
" Section: Twig {{{1
" -------------

augroup ft_twig
  autocmd!
  au BufRead,BufNewFile *.twig setlocal filetype=htmljinja
  au BufRead,BufNewFile *.twig setlocal syntax=htmljinja
  au BufNewFile,BufRead *.twig setlocal tabstop=4
  au BufNewFile,BufRead *.twig setlocal shiftwidth=4
  au BufNewFile,BufRead *.twig setlocal softtabstop=4
  au BufNewFile,BufRead *.twig setlocal expandtab
augroup END

" }}}1
" Section: XML {{{1
" ------------

autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}1


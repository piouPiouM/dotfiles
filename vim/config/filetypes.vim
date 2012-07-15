" filetypes.vim

" Section: CSS, Sass, SCSS and LessCSS {{{1
" ------------------------------------

augroup ft_css
  autocmd!
  autocmd FileType css,less,sass,scss setlocal foldmethod=marker foldmarker={,} nofoldenable
  autocmd FileType css,less,sass,scss setlocal tabstop=2
  autocmd FileType css,less,sass,scss setlocal shiftwidth=2
  autocmd FileType css,less,sass,scss setlocal softtabstop=2
  autocmd FileType css,less,sass,scss setlocal expandtab
augroup END

" }}}1
" Section: Markdown {{{1
" -----------------

augroup ft_markdown
  autocmd!
  autocmd FileType markdown setlocal wrap linebreak
  autocmd FileType markdown setlocal tabstop=4
  autocmd FileType markdown setlocal shiftwidth=4
  autocmd FileType markdown setlocal softtabstop=4
  autocmd FileType markdown setlocal expandtab
  autocmd FileType markdown setlocal textwidth=120
  autocmd FileType markdown setlocal colorcolumn=+1
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

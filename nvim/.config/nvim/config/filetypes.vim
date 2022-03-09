" filetypes.vim

" Section: Configuration files {{{1
" ----------------------------

augroup ft_conf
  autocmd!
  autocmd BufRead,BufNewFile */apache2/*.conf,*/apache2/*/.conf setlocal filetype=apache
augroup END

" }}}1
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

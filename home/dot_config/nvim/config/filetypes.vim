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

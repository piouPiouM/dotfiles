" filetypes.vim

" Section: CSS, Sass, SCSS and LessCSS {{{1
" ------------------------------------

augroup ft_css
  autocmd!
  autocmd FileType css,less,sass,scss set tabstop=2
  autocmd FileType css,less,sass,scss set shiftwidth=2
  autocmd FileType css,less,sass,scss set softtabstop=2
  autocmd FileType css,less,sass,scss set expandtab
augroup END

" }}}1
" Section: Markdown {{{1
" -----------------

augroup ft_markdown
  autocmd!
  autocmd FileType markdown set nowrap
  autocmd FileType markdown set tabstop=4
  autocmd FileType markdown set shiftwidth=4
  autocmd FileType markdown set softtabstop=4
  autocmd FileType markdown set expandtab
  autocmd FileType markdown set textwidth=120
  autocmd FileType markdown set colorcolumn=+1
augroup END

" }}}1
" Section: Twig {{{1
" -------------

augroup ft_twig
  autocmd!
  au BufRead,BufNewFile *.twig set filetype=htmljinja
  au BufRead,BufNewFile *.twig set syntax=htmljinja
  au BufNewFile,BufRead *.twig set tabstop=4
  au BufNewFile,BufRead *.twig set shiftwidth=4
  au BufNewFile,BufRead *.twig set softtabstop=4
  au BufNewFile,BufRead *.twig set expandtab
augroup END

" }}}1

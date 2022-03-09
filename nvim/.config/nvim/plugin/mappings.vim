" mappings.vim
"
" 1. General
" 2. Everyday tasks
" 3. Plugins

" Section: Command mode {{{1

" Expand ùù to file path
cabbrev <expr> ùù expand('%:p')

" Expand %% to file directory path
cabbrev <expr> %% expand('%:p:h')

" }}}1
" Section: General {{{1

" Jump to the next row instead of to jump over the current line
" when line wrapping enabled.
nnoremap j gj
nnoremap k gk

" Move selection down and up w/o ruining its register 🙌
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Always center the next search jump and open any folds.
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap Y yg$
nnoremap J mzJ`z

" Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Toggle relativenumber
nnoremap <localleader>n :setlocal relativenumber!<CR>

" Toggle cursorline
nnoremap <localleader><space> :set cursorline!<CR>

" Change content inside single quotes
nnoremap <localleader>' ci'

" Change content inside double quotes
nnoremap <localleader>" ci"

" Change content inside square brackets
nnoremap <localleader>] ci]

" Change content inside parentheses
nnoremap <localleader>) ci)

" Change content inside tag
nnoremap <localleader>t cit

" Change content inside named tag
nnoremap <localleader>< ci<

" Surround word with single quotes (visual: S')
nmap <leader>' ysiw'

" Surround word with double quotes (visual: S")
nmap <leader>" ysiw"

" Surround word with square brackets (visual: S])
nmap <leader>] ysiw]

" Surround word with parentheses (visual: S))
nmap <leader>) ysiw)

nnoremap <silent> <leader>k <C-]>

" Create window splits easier.
nnoremap <silent> <localleader>vv <C-w>v
nnoremap <silent> <localleader>ss <C-w>s

nnoremap <silent> gx :call ppm#functions#plug_gx()<CR>

" }}}1
" Section: Everyday tasks {{{1

" Clear out search with //
nnoremap <silent> // :nohlsearch<cr>

" Open a Quickfix window for the last search with <leader>/
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Close the Quickfix or Location window with <leader>//
nnoremap <silent> <leader>// :cclose<BAR>lclose<CR>

" ¨* for highlight all occurrences of current word (like '*' but without moving)
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <silent> ¨* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" }}}1
" Section: Plugins {{{1

" vim-quickhl
nmap <localleader>k <Plug>(quickhl-cword-toggle)
nmap <localleader>] <Plug>(quickhl-tag-toggle)

" ArgWrap
nnoremap <silent> <localleader>aw :ArgWrap<CR>

" vim-lion
nmap <localleader>a= glip=
nmap <localleader>a: gLi{:

" }}}1


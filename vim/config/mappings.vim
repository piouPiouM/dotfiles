" mappings.vim
"
" 1. General
" 2. Everyday tasks
" 3. Plugins

" Section: General {{{1

" Change leader to a comma because the backslash is a pain to type
let mapleader=","
let maplocalleader="ù"

" Jump to the next row instead of to jump over the current line
" when line wrapping enabled
nnoremap j gj
nnoremap k gk

" Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Toggle relativenumber
nnoremap <F5> :setlocal relativenumber!<CR>

" Change content inside single quotes
nnoremap <localleader>' ci'

" Change content inside double quotes
nnoremap <localleader>" ci"

" Change content inside square brackets
nnoremap <localleader>] ci]

" Change content inside parentheses
nnoremap <localleader>) ci)

" Surround word with single quotes (visual: S')
nmap <leader>' ysiw'

" Surround word with double quotes (visual: S")
nmap <leader>" ysiw"

" Surround word with square brackets (visual: S])
nmap <leader>] ysiw]

" Surround word with parentheses (visual: S))
nmap <leader>) ysiw)

" When typing a string, your quotes auto complete. Move past the quote
" while still in insert mode by hitting Ctrl-a. Example:
"
" type 'foo<c-a>
"
" the first quote will autoclose so you'll get 'foo' and hitting <c-a> will
" put the cursor right after the quote
inoremap <C-a> <ESC>wa

" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> <leader>f <C-]>

" Create window splits easier.
nnoremap <silent> <LocalLeader>vv <C-w>v
nnoremap <silent> <LocalLeader>ss <C-w>s

" }}}1
" Section: Everyday tasks {{{1

" Clear out search with //
nnoremap <silent> // :nohlsearch<cr>

" Open a Quickfix window for the last search with <leader>/
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Close the Quickfix or Location window with <leader>//
nnoremap <Leader>// :cclose<BAR>lclose<CR>

" ¨* for highlight all occurrences of current word (like '*' but without moving)
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <silent> ¨* :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Omnicomplete with Ctrl+space
nnoremap <C-space> <C-x><C-o>
inoremap <C-space> <C-x><C-o>

" Quick svn blame.
" http://tammersaleh.com/posts/quick-vim-svn-blame-snippet
vmap gbl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" }}}1
" Section: Plugins {{{1

" Launch Ack
"nnoremap <silent> <D-F> :Ack<space>
"inoremap <silent> <D-F> <ESC>:Ack<space>

" Invoque fzf.vim
nmap     <Space>  <Plug>[fzf]
nnoremap <silent> <Plug>[fzf]<Space> :FzfFiles <C-R>=expand('%:p:h')<CR><CR>
nnoremap <silent> <Plug>[fzf]p       :FzfGFiles --exclude-standard --cached --others<CR>
nnoremap <silent> <Plug>[fzf]b       :FzfBuffers<CR>
nnoremap <silent> <Plug>[fzf]m       :FzfHistory<CR>
nnoremap <silent> <Plug>[fzf]t       :FzfTags<CR>
nnoremap <silent> <Plug>[fzf]bt      :FzfBTags<CR>
nnoremap <silent> <Plug>[fzf]l       :FzfLines<CR>
nnoremap <silent> <Plug>[fzf]bl      :FzfBLines<CR>
nnoremap <silent> <Plug>[fzf]gc      :FzfCommits<CR>
nnoremap <silent> <Plug>[fzf]gst     :FzfGFiles?<CR>
nnoremap <silent> <Plug>[fzf]gm      :FzfGModified<CR>
nnoremap          <Plug>[fzf]s       :FzfSpotlight <C-R><C-W><Space>

" Surcharge original commands with fzf.vim
imap <C-X><C-L> <plug>(fzf-complete-line)
imap <C-X><C-F> <plug>(fzf-complete-file)
inoremap <expr> <C-X><C-K> fzf#vim#complete#word({'left': '15%'})

" LanguageClient
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <silent> <F12> <Plug>(ale_go_to_definition)

" vim-quickhl
nmap <localleader>k <Plug>(quickhl-cword-toggle)
nmap <localleader>] <Plug>(quickhl-tag-toggle)

" unimpaired
" Bubbling text in TextMate style
" http://vimcasts.org/e/26
"nmap <C-Up>   [e
"nmap <C-Down> ]e
"vmap <C-Up>   [egv
"vmap <C-Down> ]egv

" ArgWrap
nnoremap <silent> <leader>aw :ArgWrap<CR>

" vim-lion
nmap <leader>a= glip=
"vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: gLi{:
"vmap <leader>a: :Tabularize /:\zs<CR>

" }}}1


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

" Change inside quotes with ," and ,'
nnoremap <leader>' ci'
nnoremap <leader>" ci"
inoremap <leader>' <ESC>ci'
inoremap <leader>" <ESC>ci"

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
nnoremap <silent> <space>vv <C-w>v
nnoremap <silent> <space>ss <C-w>s

" }}}1
" Section: Everyday tasks {{{1

" Clear out search with //
nnoremap <silent> // :nohlsearch<cr>

" Open a Quickfix window for the last search with <leader>/
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Close the Quickfix window with <leader>//
nnoremap <Leader>// :cclose<CR>

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

" Invoque CtrlP
nmap     <space>  <Plug>[ctrlp]
nnoremap <silent> <Plug>[ctrlp]<space> :CtrlPCurFile<CR>
nnoremap <silent> <Plug>[ctrlp]p       :CtrlPRoot<CR>
nnoremap <silent> <Plug>[ctrlp]b       :CtrlPBuffer<CR>
nnoremap <silent> <Plug>[ctrlp]m       :CtrlPMRU<CR>
nnoremap <silent> <Plug>[ctrlp]t       :CtrlPBufTag<CR>
nnoremap <silent> <Plug>[ctrlp]o       :CtrlPBookmarkDir<CR>

" Invoque fzf.vim
nmap     <leader><space> <Plug>[fzf]
nnoremap <silent> <Plug>[fzf]<space> :Files <C-R>=expand('%:h')<CR><CR>
nnoremap <silent> <Plug>[fzf]p       :GFiles --exclude-standard --cached --others<CR>
nnoremap <silent> <Plug>[fzf]b       :Buffers<CR>
nnoremap <silent> <Plug>[fzf]m       :History<CR>
nnoremap <silent> <Plug>[fzf]t       :Tags<CR>
nnoremap <silent> <Plug>[fzf]bt      :BTags<CR>
nnoremap <silent> <Plug>[fzf]l       :Lines<CR>
nnoremap <silent> <Plug>[fzf]bl      :BLines<CR>

" Toggle Undotree window
nnoremap <F5> :UndotreeToggle<CR>

" LanguageClient
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" Ale
nnoremap <buffer> <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <buffer> <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <buffer> <silent> <F12> <Plug>(ale_go_to_definition)

" nvim-typescript
nnoremap <buffer> <silent> <S-F12> :TSRefs<CR>
" nnoremap <buffer> <silent> <> :TSDef<CR>
" nnoremap <buffer> <silent> <> :TSDefsPreview<CR>
" nnoremap <buffer> <silent> <> :TSType<CR>
" nnoremap <buffer> <silent> <> :TSTypeDef<CR>
" nnoremap <buffer> <silent> <> :TSImport<CR>
" nnoremap <buffer> <silent> <> :TSDoc<CR>

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

nmap ga <Plug>(UnicodeGA)

" }}}1


" mappings.vim
"
" 1. General
" 2. Everyday tasks
" 3. Dependent plugins

" Section: General {{{1
" ----------------

" Change leader to a comma because the backslash is a pain to type
let mapleader=","

" Jump to the next row instead of to jump over the current line
" when line wrapping enabled
nnoremap j gj
nnoremap k gk

" Change inside quotes with Cmd-" and Cmd-'
nnoremap <D-'> ci'
nnoremap <D-"> ci"
inoremap <D-'> <ESC>ci'
inoremap <D-"> <ESC>ci"

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
nnoremap <silent> <leader>vv <C-w>v
nnoremap <silent> <leader>ss <C-w>s

" }}}1
" Section: Everyday tasks {{{1
" -----------------------

" Save with sudo rights
cmap w!! %!sudo tee % >/dev/null

" Clear out search with //
nnoremap <silent> // :nohlsearch<cr>

" Open a Quickfix window for the last search with <leader>/
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Close the Quickfix window with <leader>//
nnoremap <Leader>// :cclose<CR>

" Cmd-* for highlight all occurrences of current word (like '*' but without moving)
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches
nnoremap <silent> <D-*> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" Omnicomplete with Ctrl+space
nnoremap <C-space> <C-x><C-o>
inoremap <C-space> <C-x><C-o>

" Quick svn blame.
" http://tammersaleh.com/posts/quick-vim-svn-blame-snippet
vmap gbl :<C-U>!svn blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" }}}1
" Section: Useful {{{1
" ---------------

" Show syntax highlighting groups for word under cursor
" http://vimcasts.org/e/25
nnoremap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}1
" Section: Plugins {{{1
" ----------------

" Launch Ack
nnoremap <silent> <D-F> :Ack<space>
inoremap <silent> <D-F> <ESC>:Ack<space>

" Invoque CtrlP
nmap     <space>  <Plug>[ctrlp]
nnoremap <silent> <Plug>[ctrlp]<space> :CtrlPCurFile<CR>
nnoremap <silent> <Plug>[ctrlp]p       :CtrlP<CR>
nnoremap <silent> <Plug>[ctrlp]b       :CtrlPBuffer<CR>
nnoremap <silent> <Plug>[ctrlp]r       :CtrlPMRU<CR>
nnoremap <silent> <Plug>[ctrlp]t       :CtrlPBufTag<CR>
nnoremap <silent> <Plug>[ctrlp]o       :CtrlPBookmarkDir<CR>

" Toggle Undotree window with Cmd-u
nnoremap <D-u> :UndotreeToggle<CR>

" }}}1
" Section: Dependent plugins {{{1
" --------------------------

" Requirements: unimpaired plugin.
function! Custom_mapping_unimpaired()
  " Bubbling text in TextMate style
  " http://vimcasts.org/e/26
  nmap <C-Up>   [e
  nmap <C-Down> ]e
  vmap <C-Up>   [egv
  vmap <C-Down> ]egv
endfunction
"call ppm#do_after_plugin("Custom_mapping_unimpaired", "unimpaired")

" Requirements: ArgWrap plugin.
function! Custom_mapping_argwrap()
  nnoremap <silent> <leader>aw :ArgWrap<CR>
endfunction
call ppm#do_after_plugin("Custom_mapping_argwrap", "argwrap")

" Requirements: Tabular plugin.
function! Custom_mapping_tabular()
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
endfunction
"call ppm#do_after_plugin("Custom_mapping_tabular", "tabular")

map y <Plug>(highlightedyank)

" }}}1


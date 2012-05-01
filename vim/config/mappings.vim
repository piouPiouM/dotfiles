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

" Go to last edit location with ,.
nnoremap <leader>. '.

"When typing a string, your quotes auto complete. Move past the quote
"while still in insert mode by hitting Ctrl-a. Example:
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
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" }}}1
" Section: Everyday tasks {{{1
" -----------------------

" Save with sudo rights
cmap w!! %!sudo tee % >/dev/null

" Clear out search with //
nnoremap <silent> // :nohlsearch<cr>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

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

" Toggle FuzzyFinder
nnoremap <silent> <F1>   :FufFileWithCurrentBufferDir<CR>
inoremap <silent> <F1>   <ESC>:FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <M-F1> :FufFileWithFullCwd<CR>
inoremap <silent> <M-F1> <ESC>:FufFileWithFullCwd<CR>
nnoremap <silent> <S-F1> :FufBuffer<CR>
inoremap <silent> <S-F1> <ESC>:FufBuffer<CR>

" Toggle NERDTree window with F2
nnoremap <silent> <F2> :NERDTreeToggle<CR>
inoremap <silent> <F2> <ESC>:NERDTreeToggle<CR>

" Toggle Gundo window with Cmd-u
nnoremap <D-u> :GundoToggle<CR>

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
call ppm#do_after_plugin("Custom_mapping_unimpaired", "unimpaired")

" }}}1


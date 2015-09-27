" plugins.vim
"
" Plugins settings
"
"  1. CtrlP
"  2. Syntastic
"  3. YankRing
"  4. vim-color-css
"  5. php.vim (syntax)
"  6. Mustache and Handlebars mode
"  7. Vim Markdown
"  8. vim-expand-region

" Section: CtrlP {{{1
" --------------

let g:ctrlp_working_path_mode     = 0   " Disable auto change directory.
let g:ctrlp_arg_map               = 1   " <c-o> and <c-y> mappings will accept one extra key.
let g:ctrlp_max_height            = 30  " Set the maximum height of the match window.
let g:ctrlp_by_filename           = 1   " Default to filename mode.
let g:ctrlp_follow_symlinks       = 1   " Follow symlinks but ignore internal loops.
let g:ctrlp_lazy_update           = 100 " Update the match window after typing's been stopped (in ms).
let g:ctrlp_match_window_bottom   = 1   " Show the match window at the bottom of the screen.
let g:ctrlp_match_window_reversed = 1   " Change the listing order of the files in the match window.
let g:ctrlp_switch_buffer         = 0   " Open files in the desired buffer.
let g:ctrlp_use_caching           = 1   " Enable caching by session.
let g:ctrlp_clear_cache_on_exit   = 0   " Do not delete the cache files upon exiting Vim.
let g:ctrlp_mruf_max              = 250 " The number of recently opened files to remember.
let g:ctrlp_mruf_relative         = 1   " Show only MRU files in the current working directory.
let g:ctrlp_cache_dir             = '~/.vim/tmp/ctrlp'
let g:ctrlp_extensions            = ['line', 'tag', 'bookmarkdir']
let g:ctrlp_custom_ignore         = {
  \ 'dir':  '\v[\/](node_modules)$',
  \ }

" }}}1
" Section: Airline {{{1
" ------------------

let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#trailing_format = '¬[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '▸[%s]'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

" }}}1
" Section: Syntastic {{{1
" ------------------

let g:syntastic_auto_jump       = 1
let g:syntastic_auto_loc_list   = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_signs    = 1
let g:syntastic_quiet_messages  = {'level': 'errors'}
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map        = { 'mode': 'active',
                                  \ 'passive_filetypes': ['sass', 'scss', 'html'] }
let g:syntastic_phpcs_disable = 1

" }}}1
" Section: YankRing {{{1
" -----------------

let g:yankring_history_dir = '~/.vim/tmp'

" }}}1
" Section: vim-color-css {{{1
" ----------------------

let g:cssColorVimDoNotMessMyUpdatetime = 1

" }}}1
" Section: php.vim (syntax) {{{1
" -------------------------

let php_sql_query          = 0
let php_html_in_strings    = 1
let php_parent_error_close = 1
let php_parent_error_open  = 1
let php_no_shorttags       = 1
let php_folding            = 1
let php_sync_method        = -1

" }}}1
" Section: Mustache and Handlebars mode {{{1
" -------------------------------------

let g:mustache_abbreviations = 1

" }}}1
" Section: Vim Markdown {{{1
" ---------------------

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter      = 1 " Highlight YAML frontmatter

" }}}1
" Section: vim-expand-region {{{1
" --------------------------

let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :1,
      \ 'i''' :1,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'ip'  :0,
      \ 'a"'  :1,
      \ 'a''' :1,
      \ 'a]'  :1,
      \ 'ab'  :0,
      \ 'aB'  :0
      \ }

" }}}1

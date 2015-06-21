" plugins.vim
"
" Plugins settings
"
" 1. CtrlP
" 2. Gundo
" 3. Neocomplcache
" 4. Syntastic
" 5. YankRing
" 6. vim-color-css
" 7. php.vim (syntax)

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
" Section: Gundo {{{1
" --------------

let g:gundo_preview_height = 40
let g:gundo_right          = 1

" }}}1
" Section: Neocomplcache {{{1
" ----------------------

let g:neocomplcache_temporary_dir     = '~/.vim/tmp/necon'
let g:neocomplcache_enable_at_startup = 1  " Enable Neocomplcache at startup.
let g:neocomplcache_max_list          = 50 " Number of candidates displayed in a pop-up menu.
let g:neocomplcache_enable_smart_case = 0  " Do not use smartcase.
let g:neocomplcache_auto_completion_start_length = 4 " Number of input to start completion.
let g:neocomplcache_enable_camel_case_completion = 1 " Enable CameCase completion.
let g:neocomplcache_enable_fuzzy_completion      = 0 " Disable fuzzy completion, it's too heavy.
let g:neocomplcache_enable_underbar_completion   = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'

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


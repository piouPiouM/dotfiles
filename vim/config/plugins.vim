" plugins.vim
"
" Plugins settings
"
" 1. CtrlP
" 2. Gundo
" 3. Powerline
" 4. Syntastic
" 6. YankRing

" Section: CtrlP {{{1
" --------------

let g:ctrlp_working_path_mode     = 0  " Disable auto change directory.
let g:ctrlp_max_height            = 30 " Set the maximum height of the match window.
let g:ctrlp_follow_symlinks       = 1  " Follow symlinks but ignore internal loops.
let g:ctrlp_match_window_bottom   = 1  " Show the match window at the bottom of the screen.
let g:ctrlp_match_window_reversed = 1  " Change the listing order of the files in the match window.
let g:ctrlp_clear_cache_on_exit   = 0  " Do not delete the cache files upon exiting Vim.
let g:ctrlp_cache_dir  = '~/.vim/tmp/ctrlp'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'bookmarkdir']

" }}}1
" Section: Gundo {{{1
" --------------

let g:gundo_preview_height = 40
let g:gundo_right          = 1

" }}}1
" Section: Powerline {{{1
" ------------------

let g:Powerline_symbols = "fancy"
function! Do_Powerline_stuff()
  set noshowmode                     " Turn off showmode
endfunction
call ppm#do_after_plugin("Do_Powerline_stuff", "Powerline")

" }}}1
" Section: Syntastic {{{1
" ------------------

let g:syntastic_auto_jump       = 1
let g:syntastic_auto_loc_list   = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_signs    = 1
let g:syntastic_quiet_warnings  = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map        = { 'mode': 'active',
                                  \ 'passive_filetypes': ['sass', 'scss', 'html'] }

" }}}1
" Section: YankRing {{{1
" -----------------

let g:yankring_history_dir = '~/.vim/tmp'

" }}}1


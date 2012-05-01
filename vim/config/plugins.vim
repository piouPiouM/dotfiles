" plugins.vim
"
" Plugins settings
"
" 1. Command-T
" 2. Gundo
" 3. Powerline
" 4. Syntastic

" Section: Command-T {{{1
" ------------------

let g:CommandTMaxCachedDirectories = 30 " Keep in cache the 30 last scanned directories.
let g:CommandTMatchWindowReverse   = 1  " Display best match in a fixed location on the screen.

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
  set noshowmode                            " Turn off showmode
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
                                  \ 'passive_filetypes': ['sass', 'scss'] }

" }}}1


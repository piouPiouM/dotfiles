" plugins.vim
"
" Plugins settings.

" Section: Ack {{{1

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

" }}}1
" Section: vim-expand-region {{{1

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
" Section: EditorConfig {{{1

let g:EditorConfig_core_mode = "external_command"
let g:EditorConfig_exec_path = "/usr/local/bin/editorconfig"
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'gitgutter://.*']

" }}}1
" Section: vim-wordmotion {{{1

let g:wordmotion_prefix = '<localleader>'

" }}}1
" Section: switch {{{1

let g:switch_mapping = "-"
let g:switch_custom_definitions =
      \ [
      \   ['top', 'left', 'bottom', 'right'],
      \   ['yes', 'no'],
      \   ['on', 'off'],
      \   ['first', 'last'],
      \   ['prev', 'next'],
      \   ['previous', 'next'],
      \   ['prefix', 'suffix'],
      \   ['else', 'else if'],
      \   ['padding', 'margin'],
      \   ['after', 'before'],
      \   ['min', 'max'],
      \ ]

" }}}1
" Section: vim-lion {{{1

let g:lion_squeeze_spaces = 1

" }}}1
" Section: VCoolor {{{1

let g:vcoolor_lowercase  = 1

" }}}1
" Section: vim-css-color {{{1

let g:cssColorVimDoNotMessMyUpdatetime = 1

" }}}1
" Section: netrw {{{1

let g:netrw_home      = $XDG_CACHE_HOME . '/nvim'
let g:netrw_liststyle = 3 " Tree view
let g:netrw_banner    = 0 " Type I to toggle banner
let g:netrw_list_hide = &wildignore

" }}}1
" Section: quickhl {{{1

let g:quickhl_cword_enable_at_startup = 0 " Use :quickhlCwordToggle instead
let g:quickhl_cword_hl_command = 'QuickhlCword ctermfg=9 cterm=underline guifg=#d08770 gui=undercurl'

" }}}1

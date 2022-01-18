" plugins.vim
"
" Plugins settings.

" Section: Colorschemes {{{1

let g:solarized_menu = 0
let g:neosolarized_italic = 1

let g:onedark_terminal_italics = 1

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

" }}}1
" Section: Ack {{{1

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

" }}}1
" Section: Completion systems {{{1

let g:echodoc_enable_at_startup = 1

let g:nvim_typescript#type_info_on_hold = 0

"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" let g:UltiSnipsExpandTrigger="<c-s-j>"
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" close the preview window when you're not using it
" let g:SuperTabClosePreviewOnPopupClose = 1
" let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<c-n>"

"let g:ycm_key_list_select_completion = ['<TAB>']

" }}}1
" Section: Mustache and Handlebars mode {{{1

let g:mustache_abbreviations = 1

" }}}1
" Section: Vim Markdown {{{1

"let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_frontmatter      = 1 " Highlight YAML frontmatter

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
" Section: vim-signify {{{1

let g:signify_vcs_list    = [ 'git' ]
"let g:signify_sign_change = '♺'


" }}}1
" Section: javascript-libraries-syntax {{{1

let g:used_javascript_libs = 'jquery,underscore,requirejs'
let g:jsdoc_enable_es6 = 1

" }}}1
" Section: vim-bookmarks {{{1

let g:bookmark_auto_save_file =  $XDG_DATA_HOME . '/nvim/vim-bookmarks'

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
" Section: colorizer {{{1

let g:colorizer_nomap = 1
let g:colorizer_startup = 0

" }}}1
" Section: vim-css-color {{{1

let g:cssColorVimDoNotMessMyUpdatetime = 1

" }}}1
" Section: rainbow parentheses improved {{{1

let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'html': 1,
      \ }

" }}}1
" Section: netrw {{{1

let g:netrw_home      = $XDG_CACHE_HOME . '/nvim'
let g:netrw_liststyle = 3 " Tree view
let g:netrw_banner    = 0 " Type I to toggle banner
let g:netrw_list_hide = &wildignore

" }}}1
" Section: csv.vim {{{1

let g:csv_nomap_space = 1

" }}}1
" Section: Elm {{{1

let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1

" }}}1
" Section: quickhl {{{1

let g:quickhl_cword_enable_at_startup = 0 " Use :quickhlCwordToggle instead
let g:quickhl_cword_hl_command = 'QuickhlCword ctermfg=9 cterm=underline guifg=#d08770 gui=undercurl'

" }}}1
" Section: vim-diminactive {{{1

let g:diminactive_enable_focus = 1
let g:diminactive_filetype_blacklist = ['startify', 'gitmessengerpopup', 'fzf']

" }}}1
" Section: Yankstack {{{1

" Remove S to keep vim-surround working in visual mode.
let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'y', 'Y']

" }}}1

" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']

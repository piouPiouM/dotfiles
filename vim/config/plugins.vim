" plugins.vim
"
" Plugins settings
"
"  1. CtrlP
"  2. Airline
"  3. IndenLine
"  4. Syntastic
"  5. php.vim (syntax)
"  6. Mustache and Handlebars mode
"  7. Vim Markdown
"  8. vim-expand-region
"  9. vim-signify
" 10. javascript-libraries-syntax
" 11. YouCompleteMe
" 12. vim-bookmarks
" 13. EditorConfig
" 14. vim-wordmotion

" Section: Colorschemes {{{1

let g:solarized_menu = 0
let g:neosolarized_italic = 1

let g:onedark_terminal_italics = 1

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

" }}}1
" Section: vim-localvimrc {{{1

let g:localvimrc_name = ['.lvimrc', '.local.vimrc', '.config/vimrc']
let g:localvimrc_ask = 1
let g:localvimrc_persistent = 0
let g:localvimrc_persistence_file = $XDG_DATA_HOME . '/nvim/localvimrc_persistent'
let g:localvimrc_whitelist = [
      \ '/var/www/atih/vagrant/www',
      \]

" }}}1
" Section: CtrlP {{{1
" --------------

let g:ctrlp_working_path_mode     = 'ra' " Disable auto change directory.
let g:ctrlp_root_markers          = ['package.json', '.editorconfig']
let g:ctrlp_arg_map               = 1   " <c-o> and <c-y> mappings will accept one extra key.
let g:ctrlp_max_height            = 30  " Set the maximum height of the match window.
let g:ctrlp_by_filename           = 0   " <c-d> to set searching by filename mode.
let g:ctrlp_regexp                = 0   " <c-r> to set regexp search mode.
let g:ctrlp_follow_symlinks       = 1   " Follow symlinks but ignore internal loops.
"let g:ctrlp_lazy_update           = 100 " Update the match window after typing's been stopped (in ms).
let g:ctrlp_match_window_bottom   = 1   " Show the match window at the bottom of the screen.
let g:ctrlp_match_window_reversed = 1   " Change the listing order of the files in the match window.
let g:ctrlp_line_prefix           = '' " ▶︎
let g:ctrlp_switch_buffer         = 0   " Open files in the desired buffer.
let g:ctrlp_use_caching           = 1   " Enable caching by session.
let g:ctrlp_clear_cache_on_exit   = 0   " Do not delete the cache files upon exiting Vim.
let g:ctrlp_mruf_max              = 250 " The number of recently opened files to remember.
let g:ctrlp_mruf_relative         = 1   " Show only MRU files in the current working directory.
let g:ctrlp_cache_dir             = $XDG_CACHE_HOME . '/nvim/ctrlp'
let g:ctrlp_extensions            = ['buffertag', 'dir', 'tag', 'changes', 'undo', 'bookmarkdir']
let g:ctrlp_show_hidden           = 1
let g:ctrlp_custom_ignore         = {
  \ 'dir':  '\v[\/](node_modules|tmp|cache)$',
  \ }
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

let g:ranger_map_keys = 0
let g:loaded_netrwPlugin = 'disable'

" }}}1
" Section: Airline {{{1
" ------------------

let g:airline_theme='base16_ocean'
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
"let g:airline_extensions = [
      "\ 'quickfix',
      "\ 'ctrlp',
      "\ 'branch',
      "\ 'hunks',
      "\ 'wordcount',
      "\ 'whitespace',
      "\ 'undotree',
      "\ 'netrw',
      "\ ]
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
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#trailing_format = '¬[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '▸[%s]'

" }}}1
" Section: IndentLine {{{1

let g:indentLine_char = "╎"

" }}}1
" Section: Neomake {{{1
" ----------------

let g:neomake_highlight_lines = 0
"let g:neomake_error_sign   = {'text': emoji#for('anger'), 'texthl': 'NeomakeErrorSign'}
"let g:neomake_warning_sign = {'text': emoji#for('pig'), 'texthl': 'NeomakeWarningSign'}
"let g:neomake_message_sign = {'text': emoji#for('thought_balloon'), 'texthl': 'NeomakeMessageSign'}

let g:neomake_php_enabled_makers = ['php']
let g:neomake_javascript_enabled_makers = ['eslint']
if executable('eslint_d')
  "let g:neomake_javascript_enabled_makers = ['eslint_d']
endif
autocmd! BufWritePost * Neomake

" }}}1
" Section: Syntastic {{{1
" ------------------

if exists('*SyntasticStatuslineFlag')
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_jump       = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_enable_balloons = 1
  let g:syntastic_enable_signs    = 1
  let g:syntastic_loc_list_height = 5
  let g:syntastic_quiet_messages  = {'level': 'errors'}
  let g:syntastic_error_symbol = '💢'
  let g:syntastic_style_error_symbol = '⁉️'
  let g:syntastic_warning_symbol = '⚠️'
  let g:syntastic_style_warning_symbol = '💩'
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exec = 'eslint_d'
  let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'passive_filetypes': ['sass', 'scss', 'html'] }

  highlight link SyntasticErrorSign SignColumn
  highlight link SyntasticWarningSign SignColumn
  highlight link SyntasticStyleErrorSign SignColumn
  highlight link SyntasticStyleWarningSign SignColumn
endif


" }}}1
" Section: php.vim (syntax) {{{1
" -------------------------

let php_sql_query          = 0
let php_sql_heredoc        = 0
let php_html_load          = 1
let php_html_in_strings    = 0
let php_html_in_heredoc    = 0
let php_parent_error_close = 0
let php_parent_error_open  = 0
let php_no_shorttags       = 1
let php_folding            = 0

if !exists("g:vdebug_options")
  let g:vdebug_options = {}
endif
let g:vdebug_options['ide_key'] = 'VIM_XDEBUG'
let g:vdebug_options['break_on_open'] = 0 " Do not break at first line of my scripts
let g:vdebug_options['watch_window_style'] = 'compact'

" }}}1
" Section: Mustache and Handlebars mode {{{1
" -------------------------------------

let g:mustache_abbreviations = 1

" }}}1
" Section: Vim Markdown {{{1
" ---------------------

"let g:vim_markdown_folding_disabled = 1
"let g:vim_markdown_frontmatter      = 1 " Highlight YAML frontmatter

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
" Section: vim-signify {{{1
" --------------------

let g:signify_vcs_list    = [ 'git' ]
"let g:signify_sign_change = '♺'

let g:gitgutter_override_sign_column_highlight = 0
"let g:gitgutter_sign_added            = emoji#for('small_blue_diamond')
"let g:gitgutter_sign_modified         = emoji#for('small_orange_diamond')
"let g:gitgutter_sign_removed          = emoji#for('small_red_triangle_down')
"let g:gitgutter_sign_modified_removed = emoji#for('collision')

" }}}1
" Section: javascript-libraries-syntax {{{1
" ------------------------------------

let g:used_javascript_libs = 'jquery,underscore,react,flux,requirejs,angularjs,handlebars'

let g:jsdoc_enable_es6 = 1

" }}}1
" Section: Completion systems {{{1
" ---------------------------

let g:LanguageClient_serverCommands = {
      \ 'javascript': [$PPM_YARN_PREFIX . '/javascript-typescript-stdio'],
      \ 'javascript.jsx': [$PPM_YARN_PREFIX . '/javascript-typescript-stdio'],
      \ }

let g:echodoc_enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#max_menu_width = 60
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
      \ 'tern#Complete',
      \ 'jspc#omni'
      \ ]
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs'] " buffer, ultisnips
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabDefaultCompletionType = 'context'


let g:LanguageClient_signColumnAlwaysOn = 1
let g:LanguageClient_diagnosticsDisplay = {
      \ 1: {
      \     "name": "Error",
      \     "signText": "",
      \     "signTexthl": "NeoMakeErrorSign"
      \ },
      \ 2: {
      \     "name": "Warning",
      \     "signText": "",
      \     "signTexthl": "NeoMakeWarningSign"
      \ },
      \ 3: {
      \     "name": "Information",
      \     "texthl": "LanguageClientInformation",
      \     "signText": "",
      \     "signTexthl": "SignInformation"
      \ },
      \ 4: {
      \     "name": "Hint",
      \     "texthl": "LanguageClientHint",
      \     "signText": "",
      \     "signTexthl": "SignHint"
      \ }
      \ }

"let g:ycm_key_list_select_completion = ['<TAB>']

" }}}1
" Section: vim-bookmarks {{{1
" ----------------------

let g:bookmark_auto_save_file =  $XDG_DATA_HOME . '/nvim/vim-bookmarks'

" }}}1
" Section: EditorConfig {{{1
" ---------------------

let g:EditorConfig_core_mode = "external_command"
let g:EditorConfig_exec_path = "/usr/local/bin/editorconfig"

" }}}1
" Section: vim-wordmotion {{{1
" -----------------------

let g:wordmotion_prefix = '<Leader>'

" }}}1
" Section: Startify {{{1
" -----------------

let g:startify_enable_special = 0
let g:startify_session_dir =  $XDG_DATA_HOME . '/nvim/startify-session'
let g:startify_fortune_use_unicode = 1
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ ]
let g:startify_bookmarks = [
      \ '/var/www/atih/vagrant/www/internet/',
      \ '/var/www/atih/vagrant/www/scansante/',
      \ '/var/www/fpul/www/',
      \ '/var/www/formation/reactjs/',
      \ ]
let g:startify_list_order = [
      \ ['   Bookmarks:'],
      \ 'bookmarks',
      \ ['   Recently used files:'],
      \ 'files',
      \ ['   MRU in the current directory:'],
      \ 'dir',
      \ ['   Sessions:'],
      \ 'sessions',
      \ ['   Commands:'],
      \ 'commands'
      \ ]

" }}}1
" Section: switch {{{1
" ---------------

let g:switch_mapping = "-"
let g:switch_custom_definitions =
      \ [
      \   ['top', 'bottom'],
      \   ['left', 'right'],
      \   ['yes', 'no'],
      \   ['on', 'off'],
      \   ['first', 'last'],
      \   ['else', 'else if'],
      \ ]
autocmd FileType gitrebase let b:switch_custom_definitions =
      \ [
      \   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec' ]
      \ ]
autocmd FileType php let b:switch_custom_definitions =
      \ [
      \   {
      \     '\CTRUE':  'FALSE',
      \     '\CFALSE': 'TRUE',
      \   }
      \ ]

" }}}1
" Section: JSON {{{1

let g:vim_json_syntax_conceal = 1

"}}}1
" Section: vim-lion {{{1

let g:lion_squeeze_spaces = 1

" }}}1
" Section: VCoolor {{{1

let g:vcoolor_lowercase  = 1
let g:vcoolor_map        = '<D-C>'
let g:vcool_ins_rgb_map  = '<D-R>' " Insert rgb color.
let g:vcool_ins_hsl_map  = '<D-V>' " Insert hsl color.
let g:vcool_ins_rgba_map = '<D-W>' " Insert rgba color.

" }}}1
" Section: colorizer {{{1

let g:colorizer_nomap = 1

" }}}1
" Section: Ack {{{1

if executable('ag')
  "let g:ackprg = 'ag --vimgrep'
endif

" }}}1
" Section: vim-css-color {{{1

let g:cssColorVimDoNotMessMyUpdatetime = 1

" }}}1
" Section: rainbow parentheses improved {{{1

let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'html': 0,
      \ }

" }}}1
" Section: webdevicons {{{1

"  
" 
" 
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
      \ 'css'     : '',
      \ 'less'    : '',
      \ 'html'    : '',
      \ 'module'  : '',
      \ 'install' : '',
      \ 'inc'     : '',
      \ 'info'    : '',
      \ 'svg'     : '',
      \ 'md'      : '',
      \ 'markdown': '',
      \ }

" }}}1
" Section: lexima {{{1

" Don't close if add pair just before a word
call lexima#add_rule({'char': '(', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '[', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '{', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '"', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': "'", 'at': '\%#[0-9a-zA-Z]', 'leave': 0})

" }}}1

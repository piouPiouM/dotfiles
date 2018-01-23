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
" Section: vim-follow-my-lead {{{1

let g:fml_all_sources = 1

" }}}1
" Section: vim-localvimrc {{{1

let g:localvimrc_name = ['.git/vimrc', '.lvimrc', '.local.vimrc', '.config/vimrc']
let g:localvimrc_ask = 1
let g:localvimrc_persistent = 0
let g:localvimrc_sandbox = 0
let g:localvimrc_persistence_file = $XDG_DATA_HOME . '/nvim/localvimrc_persistent'
let g:localvimrc_whitelist = []

" }}}1
" Section: CtrlP {{{1

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
let g:ctrlp_line_prefix           = '> ' " ▶︎
let g:ctrlp_switch_buffer         = 0   " Open files in the desired buffer.
let g:ctrlp_clear_cache_on_exit   = 0   " Do not delete the cache files upon exiting Vim.
let g:ctrlp_mruf_max              = 250 " The number of recently opened files to remember.
let g:ctrlp_mruf_relative         = 1   " Show only MRU files in the current working directory.
let g:ctrlp_cache_dir             = $XDG_CACHE_HOME . '/nvim/ctrlp'
let g:ctrlp_extensions            = ['buffertag', 'dir', 'tag', 'changes', 'undo', 'bookmarkdir']
let g:ctrlp_show_hidden           = 1
let g:ctrlp_custom_ignore         = {
  \ 'dir':  '\v[\/](node_modules|elm-stuff|tmp|cache)$',
  \ }

if executable('rg')
  let g:ctrlp_user_command = "rg --files --no-heading --hidden -g '!.git' %s"
  let g:ctrlp_use_caching = 0   " Disable caching by session.
elseif executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_use_caching = 0   " Disable caching by session.
else
  let g:ctrlp_use_caching = 1   " Enable caching by session.
endif

" }}}1
" Section: fzf.vim {{{1

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-x': 'split',
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_tags_command = 'ctags'

" Lightweight UI
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Files with preview
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(
      \   <q-args>,
      \   <bang>0 ? fzf#vim#with_preview('up:60%', '?')
      \           : fzf#vim#with_preview('right:70%:hidden', '?'),
      \   <bang>0)

" Command for ripgrep
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --line-number --no-messages --no-heading --color=always --smart-case --hidden --no-ignore-vcs '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%', '?')
      \           : fzf#vim#with_preview('right:60%:hidden', '?'),
      \   <bang>0)

" TODO: creates a command to display the jump list (`:ju[mps]`)

" }}}1
" Section: Ack {{{1

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

" }}}1
" Section: Airline {{{1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_base16_improved_contrast = 1

let g:airline_powerline_fonts=1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.readonly = " "
let g:airline_detect_paste=1
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
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#trailing_format = '¬[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '▸[%s]'
let g:airline#extensions#tagbar#flags = 's'

let g:airline_section_c="%<%f%#__accent_red#%m%#__restore__# %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"

" }}}1
" Section: vim-polyglot {{{1

let g:polyglot_disabled = ['elm', 'typescript']

" }}}1
" Section: IndentLine {{{1

let g:indentLine_char = "│"
let g:indentLine_fileTypeExclude = ["markdown", "json", "help"]
let g:indentLine_bufNameExclude = ["NERD_tree.*", "startify"]

" }}}1
" Section: Ale {{{1

let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error   = '●'
let g:ale_sign_warning = ''
let g:ale_sign_info    = ''
let g:ale_sign_style_error = '⚡︎'
let g:ale_sign_style_warning = '✽'

let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Do not lint or fix minified files.
let g:ale_pattern_options = {
      \ '\.min\.js$':  {'ale_enabled': 0},
      \ '\.min\.css$': {'ale_enabled': 0},
      \ }

" Do not use 'tsserver' to avoid slowdown of system because of LSP support
" offers by nvim-typescript plugin.
let g:ale_linters = {
      \ 'typescript': ['eslint', 'tslint', 'typecheck']
      \ }

if executable('eslint_d')
  let g:ale_javascript_eslint_executable = 'eslint_d'
  let g:ale_javascript_eslint_use_global = 1
endif

" }}}1
" Section: Completion systems {{{1

let g:echodoc_enable_at_startup = 1

let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
      \ 'javascript':     ['/usr/local/bin/javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio'],
      \ 'javascript.jsx': ['/usr/local/bin/javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio'],
      \ 'typescript':     ['/usr/local/bin/javascript-typescript-stdio', '--logfile', '/tmp/javascript-typescript-stdio'],
      \ 'html': ['/usr/local/bin/html-languageserver', '--stdio'],
      \ 'css':  ['/usr/local/bin/css-languageserver', '--stdio'],
      \ 'sass': ['/usr/local/bin/css-languageserver', '--stdio'],
      \ 'scss': ['/usr/local/bin/css-languageserver', '--stdio'],
      \ }
let g:LanguageClient_signColumnAlwaysOn = 1
let g:LanguageClient_diagnosticsDisplay = {
      \ 1: { "name": "Error",
      \      "signText": "●",
      \      "signTexthl": "ALEErrorSign"
      \    },
      \ 2: { "name": "Warning",
      \      "signText": "",
      \      "signTexthl": "ALEWarningSign"
      \    },
      \ 3: { "name": "Information",
      \      "signText": "",
      \      "signTexthl": "SignInformation",
      \      "texthl": "LanguageClientInformation"
      \    },
      \ 4: { "name": "Hint",
      \      "signText": "",
      \      "signTexthl": "SignHint",
      \      "texthl": "LanguageClientHint"
      \    }
      \ }

let g:nvim_typescript#type_info_on_hold = 0

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#file#enable_buffer_path = 1
" let g:deoplete#auto_complete_delay = 35
" let g:deoplete#auto_refresh_delay = 500
"let g:deoplete#enable_refresh_always = 1
let g:deoplete#delimiters = ['/', '.']
"let g:deoplete#omni#functions = {}
"let g:deoplete#omni#functions.javascript = [
      "\ 'tern#Complete',
      "\ 'jspc#omni'
      "\ ]
"let g:deoplete#sources = {}
"let g:deoplete#sources['javascript.jsx'] = ['file', 'ternjs'] " buffer, ultisnips
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000

"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<c-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" close the preview window when you're not using it
" let g:SuperTabClosePreviewOnPopupClose = 1
" let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<c-n>"

"let g:ycm_key_list_select_completion = ['<TAB>']

" }}}1
" Section: PHP {{{1
" php.vim (syntax) {{{2

let php_sql_query          = 0
let php_sql_heredoc        = 0
let php_html_load          = 1
let php_html_in_strings    = 0
let php_html_in_heredoc    = 0
let php_parent_error_close = 0
let php_parent_error_open  = 0
let php_no_shorttags       = 1
let php_folding            = 0

" }}}2
" vdebug {{{2

if !exists("g:vdebug_options")
  let g:vdebug_options = {}
endif
let g:vdebug_options['ide_key'] = 'VIM_XDEBUG'
let g:vdebug_options['break_on_open'] = 0 " Do not break at first line of my scripts
let g:vdebug_options['watch_window_style'] = 'compact'

" }}}2
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

let g:gitgutter_override_sign_column_highlight = 0
"let g:gitgutter_sign_added            = emoji#for('small_blue_diamond')
"let g:gitgutter_sign_modified         = emoji#for('small_orange_diamond')
"let g:gitgutter_sign_removed          = emoji#for('small_red_triangle_down')
"let g:gitgutter_sign_modified_removed = emoji#for('collision')

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
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" }}}1
" Section: vim-wordmotion {{{1

let g:wordmotion_prefix = '<Leader>'

" }}}1
" Section: Startify {{{1

let g:startify_enable_special = 0
let g:startify_session_dir =  $XDG_DATA_HOME . '/nvim/startify-session'
let g:startify_fortune_use_unicode = 1
let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ ]
let g:startify_bookmarks = [] " See $HOME/.local/vimrc
let g:startify_list_order = [
      \ ['  Bookmarks:'],
      \ 'bookmarks',
      \ ['  MRU in the current directory:'],
      \ 'dir',
      \ ['  Recently used files:'],
      \ 'files',
      \ ['  Sessions:'],
      \ 'sessions',
      \ ['  Commands:'],
      \ 'commands'
      \ ]

" }}}1
" Section: switch {{{1

let g:switch_mapping = "-"
let g:switch_custom_definitions =
      \ [
      \   ['top', 'bottom'],
      \   ['left', 'right'],
      \   ['yes', 'no'],
      \   ['on', 'off'],
      \   ['first', 'last'],
      \   ['previous', 'next'],
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
      \ 'html': 0,
      \ }

" }}}1
" Section: webdevicons {{{1

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

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
" Section: netrw {{{1

let g:netrw_home=$XDG_CACHE_HOME . '/nvim'
let g:netrw_liststyle = 3
let g:netrw_list_hide = &wildignore

" }}}1
" Section: NERDTree {{{1

let g:NERDTreeMinimalUI=1 " Disables display of the 'Bookmarks' label and 'Press ? for help' text.
let g:NERDTreeNaturalSort = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" }}}1
" Section: NERDCommenter {{{1

let g:NERDSpaceDelims = 1

" }}}1
" Section: lexima {{{1

" Don't close if add pair just before a word
call lexima#add_rule({'char': '(', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '[', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '{', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': '"', 'at': '\%#[0-9a-zA-Z]', 'leave': 0})
call lexima#add_rule({'char': "'", 'at': '\%#[0-9a-zA-Z]', 'leave': 0})

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

" }}}1

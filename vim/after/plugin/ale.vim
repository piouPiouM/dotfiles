if !exists('g:loaded_ale')
  finish
endif

let g:airline#extensions#ale#enabled = 1
let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error   = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_info    = ''
let g:ale_sign_style_error = '⚡︎'
let g:ale_sign_style_warning = '✽'

let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1

let g:ale_warn_about_trailing_blank_lines = 0

" Do not lint or fix minified files.
let g:ale_pattern_options = {
      \ '\.min\.js$':  {'ale_enabled': 0},
      \ '\.min\.css$': {'ale_enabled': 0},
      \ }

let g:ale_linters_explicit = 0
let g:ale_linters = {
      \ 'scss': ['stylelint'],
      \ 'sh': ['shellcheck', 'shell'],
      \ 'html': ['htmlhint'],
      \ }

let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_css_prettier_options = '--parser css'
let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'scss': ['stylelint'],
      \ 'css': ['prettier'],
      \ 'elm': ['format'],
      \ }

if executable('eslint_d')
  let g:ale_javascript_eslint_executable = 'eslint_d'
  let g:ale_javascript_eslint_use_global = 0
endif

let g:ale_html_htmlhint_options = '--rules tagname-lowercase,attr-value-double-quotes,attr-no-duplication,tag-pair,tag-self-close,spec-char-escape,id-unique,src-not-empty,title-require,alt-require'

let g:ale_html_tidy_options = '-q -e -language en
      \ --custom-tags yes
      \ --strict-tags-attributes 0
      \ --fix-uri no
      \ --show-body-only 1
      \ --mute-id 0
      \ --mute PROPRIETARY_ATTRIBUTE,PROPRIETARY_ELEMENT'



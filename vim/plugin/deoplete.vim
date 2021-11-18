if !exists('g:loaded_deoplete')
  finish
endif

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
call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])


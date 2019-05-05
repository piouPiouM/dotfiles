if !exists('g:is_vdebug_loaded')
  finish
endif

if !exists("g:vdebug_options")
  let g:vdebug_options = {}
endif

let g:vdebug_options['ide_key'] = 'VIM_XDEBUG'
let g:vdebug_options['break_on_open'] = 0 " Do not break at first line of my scripts
let g:vdebug_options['watch_window_style'] = 'compact'


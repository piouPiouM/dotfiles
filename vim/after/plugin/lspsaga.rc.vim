if !exists('g:loaded_lspsaga') | finish | endif

lua <<EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  code_action_prompt = {
    enable = false
  }
}
EOF

nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>
nnoremap <silent> K :Lspsaga hover_doc<CR>


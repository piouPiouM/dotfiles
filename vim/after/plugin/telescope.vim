nnoremap <Space><Space> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <Space>e       <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <Space>f       <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Space>b       <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Space>m       <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <Space>p       <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <Space>a       <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap gd             <cmd>lua require('telescope.builtin').lsp_definitions()<cr>

nnoremap <Space><Space> <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<cr>
nnoremap <Space>e       <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap <Space>f       <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Space>b       <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Space>m       <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <Space>p       <cmd>lua require('telescope.builtin').git_files()<cr>
" nnoremap <Space>fh      <cmd>lua require('telescope.builtin').help_tags()<cr>

lua <<EOF
local action_layout = require('telescope.actions.layout')

require'telescope'.setup {
  defaults = {
    -- layout_config = {
    --   flex = { width = 0.9 }
    --   -- other layout configuration here
    -- },
    mappings = {
      n = {
        ['<C-p>'] = action_layout.toggle_preview,
        ['?'] = action_layout.toggle_preview
      },
      i = {
        ['<C-p>'] = action_layout.toggle_preview
      },
    },
    pickers = {
      find_files = {
        theme = "ivy"
      }
    },
    -- other defaults configuration here
  },
  -- other configuration values here
}

require'telescope'.load_extension('fzf')

EOF

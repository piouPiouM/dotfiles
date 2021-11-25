local actions = require'telescope.actions'
local action_layout = require'telescope.actions.layout'
local themes = require'telescope.themes'
local builtin = require'telescope.builtin'

require'telescope'.setup {
  defaults = {
    prompt_prefix = " ",
    layout_config = {
      flex = {
        preview_width = 0.8,
        width = 1
      },
    },
    mappings = {
      n = {
        ['<C-p>'] = action_layout.toggle_preview,
        ['p'] = action_layout.toggle_preview
      },
      i = {
        ['<C-p>'] = action_layout.toggle_preview,
      },
    },
  },
  pickers = {
    fd = {
      theme = "ivy"
    },
    find_files = {
      theme = "ivy"
    },
    lsp_code_actions = {
      theme = "cursor",
      title = "Code action"
    }
  },
}

require'telescope'.load_extension('fzf')


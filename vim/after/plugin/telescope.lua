local actions = require'telescope.actions'
local action_layout = require'telescope.actions.layout'

local config = {
  bottom_pane = {
    preview_width = 0.6,
  },
  horizontal = {
    preview_width = 0.6,
    width = 0.9
  },
  vertical = {
    preview_cutoff = 80
  },
  ivy = {
    theme = "ivy",
    preview_width = 0.6,
    preview = {
      hide_on_startup = true,
    }
  },
}

require'telescope'.setup {
  defaults = {
    cache_picker = {
      num_pickers = 5,
    },
    prompt_prefix = " ",
    selection_caret = " ",
    layout_strategy = 'flex',
    layout_config = {
      bottom_pane = config.bottom_pane,
      horizontal = config.horizontal,
      flex = {
        horizontal = config.horizontal
      },
    },
    winblend = 15,
    mappings = {
      n = {
        ['<C-p>'] = action_layout.toggle_preview,
        ['p'] = action_layout.toggle_preview
      },
      i = {
        ['<C-p>'] = action_layout.toggle_preview,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    buffers = {
      theme = "dropdown",
      ignore_current_buffer = true,
      sort_mru = true,
    },
    fd = config.ivy,
    find_files = config.ivy,
    oldfiles = {
      preview = {
        hide_on_startup = true,
      }
    },
    lsp_code_actions = {
      theme = "cursor",
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
    }
  }
}

require'telescope'.load_extension('fzf')


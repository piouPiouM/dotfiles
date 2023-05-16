local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"

local ui = require "ppm.ui"

local config = {
  bottom_pane = { preview_width = 0.6 },
  horizontal = { preview_width = 0.6, width = 0.9 },
  vertical = { preview_cutoff = 80 },
  ivy = { theme = "ivy", preview_width = 0.6, preview = { hide_on_startup = true } },
}

require "telescope".setup {
  defaults = {
    cache_picker = { num_pickers = 5 },
    prompt_prefix = " " .. ui.icons.search .. " ",
    selection_caret = ui.icons.caret .. " ",
    layout_strategy = "flex",
    layout_config = {
      bottom_pane = config.bottom_pane,
      horizontal = config.horizontal,
      flex = { horizontal = config.horizontal },
    },
    winblend = 0,
    mappings = {
      n = {
        ["<C-p>"] = action_layout.toggle_preview,
        ["p"] = action_layout.toggle_preview,
        -- ['<cr>'] = custom_actions.fzf_multi_select,
      },
      i = {
        ["<C-p>"] = action_layout.toggle_preview,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
        -- ['<cr>'] = custom_actions.fzf_multi_select,
      },
    },
  },
  pickers = {
    buffers = { theme = "dropdown", ignore_current_buffer = true, sort_mru = true },
    fd = config.ivy,
    find_files = vim.tbl_extend("force", config.ivy, { find_command = { "rg", "--files" } }),
    oldfiles = { preview = { hide_on_startup = true } },
    colorscheme = { enable_preview = true },
  },
}

local load_extension = require("telescope").load_extension
-- require("telescope").load_extension("ui-select")
load_extension("notify")

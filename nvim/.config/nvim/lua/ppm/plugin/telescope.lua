local actions = require "telescope.actions"
local action_layout = require "telescope.actions.layout"
local lga_actions = require("telescope-live-grep-args.actions")
-- local action_state = require "telescope.actions.state"
local ui = require "ppm.ui"

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-889122232
-- TODO: breaks `symbols` builtin command
--[[ local custom_actions = {
  fzf_multi_select = function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())

    if num_selections > 1 then
      local picker = action_state.get_current_picker(prompt_bufnr)
      for _, entry in ipairs(picker:get_multi_selection()) do
        vim.cmd(string.format("%s %s", ":vsplit!", entry.value))
      end
      vim.cmd("stopinsert")
    else
      actions.file_edit(prompt_bufnr)
    end
  end,
} ]]
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
  extensions = {
    -- ["ui-select"] = { themes.get_cursor() },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt({ postfix = " -t" .. vim.bo.filetype }),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    },
  },
}

local load_extension = require("telescope").load_extension
-- require("telescope").load_extension("ui-select")
load_extension("file_browser")
load_extension("fzf")
load_extension("live_grep_args")
load_extension("notify")

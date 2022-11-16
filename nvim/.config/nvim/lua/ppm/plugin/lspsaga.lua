local saga = require("lspsaga")
local ui = require("ppm.ui")
local keymaps = require("ppm.keymaps")

saga.init_lsp_saga({
  border_style = "rounded",
  code_action_icon = ui.icons.bulb,
  code_action_lightbulb = { virtual_text = false },
  diagnostic_header = { ui.icons.error, ui.icons.warn, ui.icons.info, ui.icons.hint },
  finder_request_timeout = 5000,
  rename_in_select = false,
  max_preview_lines = 40,
  saga_winblend = 10,
  symbol_in_winbar = { enable = false, in_custom = false },
  show_outline = { win_with = "Neotree" },

  -- Keymaps
  code_action_keys = { quit = "q", exec = "<cr>" },
  finder_action_keys = {
    open = keymaps.open,
    vsplit = keymaps.vsplit,
    split = keymaps.split,
    scroll_down = keymaps.scroll_down,
    scroll_up = keymaps.scroll_up,
  },
  definition_action_keys = {
    edit = "<C-c>" .. keymaps.open,
    vsplit = "<C-c>" .. keymaps.vsplit,
    split = "<C-c>" .. keymaps.split,
    tabe = "<C-c>" .. keymaps.tabe,
    quit = "q",
  },
})

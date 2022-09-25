local saga = require("lspsaga")
local ui = require("ppm.ui")
local keymaps = require("ppm.keymaps")

saga.init_lsp_saga({
  code_action_icon = ui.icons.bulb,
  code_action_lightbulb = { virtual_text = false },
  diagnostic_header = { ui.icons.error, ui.icons.warn, ui.icons.info, ui.icons.hint },
  finder_request_timeout = 5000,
  finder_action_keys = {
    open = keymaps.open,
    vsplit = keymaps.vsplit,
    split = keymaps.split,
    scroll_down = keymaps.scroll_down,
    scroll_up = keymaps.scroll_up,
  },
  max_preview_lines = 40,
  saga_winblend = 10,
  code_action_keys = { quit = { "q", "<Esc>", "<C-e>", "<C-c>" }, exec = "<cr>" },
  symbol_in_winbar = { enable = true, in_custom = true },
  show_outline = { win_with = "Neotree" },
})

local ui = require("ppm.ui")
local keymaps = require("ppm.keymaps")

require("lspsaga").setup({
  kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
  ui = {
    border = "rounded",
    winblend = 10,
    code_action = ui.icons.action,
    expand = ui.icons.expand,
    collapse = ui.icons.collapse,
    incoming = ui.icons.incoming,
    outgoing = ui.icons.outgoing,
    hover = ui.icons.hover,
    actionfix = ui.icons.actionfix,
  },
  hover = { open_link = "gx", open_browser = "!firefox" },
  diagnostic = {
    -- keys = {
    --   exec_action = 'o',
    --   quit = 'q',
    --   expand_or_jump = '<CR>',
    --   quit_in_show = { 'q', '<ESC>' },
    -- },
  },
  code_action = {
    show_server_name = true,
    extend_gitsigns = true,
    keys = { quit = "q", exec = "<CR>" },
  },
  lightbulb = { virtual_text = false },
  preview = { lines_above = 2, lines_below = 10 },
  scroll_preview = { scroll_down = keymaps.scroll_down, scroll_up = keymaps.scroll_up },
  finder = {
    left_width = 0.4,
    right_width = 0.6,
    keys = {
      expand_or_jump = keymaps.open,
      vsplit = keymaps.vsplit,
      split = keymaps.split,
      tabe = keymaps.tabe,
    },
  },
  definition = {
    edit = "<C-c>" .. keymaps.open,
    vsplit = "<C-c>" .. keymaps.vsplit,
    split = "<C-c>" .. keymaps.split,
    tabe = "<C-c>" .. keymaps.tabe,
    quit = "q",
  },
  rename = { in_select = false },
  request_timeout = 5000,
  symbol_in_winbar = {
    enable = false,
    separator = " 󰅂 ",
    ignore_patterns = {},
    hide_keyword = true,
    show_file = false,
    folder_level = 2,
    respect_root = true,
    color_mode = true,
  },
  outline = { win_with = "Neotree" },
  -- diagnostic_header = { ui.icons.error, ui.icons.warn, ui.icons.info, ui.icons.hint },
})

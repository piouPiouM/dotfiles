-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
local codecompanion = require("ppm.plugin.lualine.components.codecompanion")
local macro_is_recording = require("ppm.plugin.lualine.components.macro")
local ui = require("ppm.ui")
local icons = ui.icons

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict

  if gitsigns then
    return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
  end
end

local function symbolwinbar()
  return require('lspsaga.symbolwinbar'):get_winbar()
end


local file_status_symbols = {
  modified = icons.modified,
  readonly = icons.readonly,
  unnamed = "[No Name]",
  newfile = "[New]",
}

local winbar = {
  lualine_a = {
    {
      "filetype",
      icon_only = true,
      separator = "",
      padding = { left = 1, right = 0 }
    },
    {
      "filename",
      newfile_status = true,
      symbols = file_status_symbols
    },
  },
  lualine_c = {
    {
      symbolwinbar,
      draw_empty = true,
      separator = { left = "" },
    },
  },
  lualine_y = {
    {
      "diagnostics",
      sources = { "nvim_diagnostic", "nvim_lsp" },
      sections = { "error", "warn" },
      separator = "",
      padding = { left = 1, right = 0 },
    },
    {
      "diff",
      source = diff_source,
      symbols = { added = icons.diff_added, modified = icons.diff_modified, removed = icons.diff_removed },
      cond = function() return vim.api.nvim_get_option_value("filetype", {}) ~= "alpha" end,
    },
  },
}

local inactive_winbar = { lualine_a = winbar.lualine_a, lualine_y = winbar.lualine_y }

local fmt_mode = function(str)
  if str == "V-BLOCK" then return "B" end

  return str:sub(1, 1)
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { winbar = { "alpha" } },
    always_divide_middle = false,
    globalstatus = true,
  },
  winbar = winbar,
  inactive_winbar = inactive_winbar,
  sections = {
    lualine_a = { { "mode", fmt = fmt_mode } },
    lualine_b = { { "b:gitsigns_head", icon = icons.git_head } },
    lualine_c = { { "filename", file_status = true, path = 3, symbols = file_status_symbols } },
    lualine_x = {
      {
        macro_is_recording,
        color = { fg = "#333333", bg = "#ff6666" },
        separator = { left = "", right = " " },
      },
      {
        codecompanion,
        cond = function() return vim.tbl_get(require("lazy.core.config"), "plugins", "copilot.lua", "_", "installed") end,
      },
      {
        "copilot",
        cond = function() return vim.tbl_get(require("lazy.core.config"), "plugins", "copilot.lua", "_", "installed") end,
        show_colors = true,
        symbols = {
          status = {
            icons = {
              enabled = " ",
              sleep = " ",
              disabled = " ",
              warning = " ",
              unknown = " "
            },
            hl = {
              enabled = require('copilot-lualine.colors').get_hl_value(0, "DiagnosticSignOk", "fg"),
              sleep = require('copilot-lualine.colors').get_hl_value(0, "DiagnosticSignInfo", "fg"),
              disabled = require('copilot-lualine.colors').get_hl_value(0, "DiagnosticSignHint", "fg"),
              warning = require('copilot-lualine.colors').get_hl_value(0, "DiagnosticSignWarn", "fg"),
              unknown = require('copilot-lualine.colors').get_hl_value(0, "DiagnosticSignHint", "fg"),
            }
          },
          spinners = require("copilot-lualine.spinners").dots,
          spinner_color = "#6272A4"
        },
      }
    },
    lualine_y = {
      { "searchcount" },
      {
        "encoding",
        cond = function() return vim.api.nvim_get_option_value("fileencoding", {}) ~= "utf-8" end,
      },
      {
        "fileformat",
        cond = function() return vim.api.nvim_get_option_value("fileformat", {}) ~= "unix" end,
      },
      "filetype",
    },
    lualine_z = { "location" },
  },
  inactive_sections = {}, -- No longer useful since I use the global status bar.
  tabline = {},
  extensions = { "lazy", "fzf", "neo-tree", "oil", "quickfix", "trouble" },
})
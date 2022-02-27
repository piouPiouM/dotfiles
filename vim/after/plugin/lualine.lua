-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
local fmt_mode = function(str)
  if str == "V-BLOCK" then return "B" end

  return str:sub(1, 1)
end

require"lualine".setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { { "mode", fmt = fmt_mode } },
    lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp", "coc" } } },
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = { "encoding", "fileformat", "filetype" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { "branch", "diff" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = { "quickfix" },
}

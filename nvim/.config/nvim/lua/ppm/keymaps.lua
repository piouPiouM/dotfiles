local code_key = function(key) return "<leader>g" .. key end
local search_key = function(key) return "<leader>" .. (key or "") end

local M = {
  open = "o",
  split = "s",
  vsplit = "v",
  tabe = "t",
  scroll_down = "<C-d>",
  scroll_up = "<C-u>",
  completion = { complete = "<C-Space>", escape = "<C-e>" },
  search = {
    buffer = { key = search_key("b"), desc = "Search buffers" },
    oldfile = { key = search_key("m"), desc = "Search recent files (MRU)" },
    file = { key = search_key("p"), desc = "Search files" },
    file_cwd = { key = search_key("<Space>"), desc = "Search files in current directory" },
    git_file = { key = search_key("s"), desc = "Search files in git repository" },
    grep = { key = search_key("fg"), desc = "Live grep" },
    grep_cursor = { key = search_key("f;"), desc = "Search word under the cursor" },
    help_tags = { key = search_key("H"), desc = "Search in Neovim help" },
    tree_reveal = { key = search_key("R"), desc = "Reaveal current file in file browser" },
    tree_reveal_cursor = {
      key = search_key(";"),
      desc = "Reveal file under the cursor in file browser",
    },
  },
  lsp = {
    codeaction = { key = code_key("a"), desc = "Display code actions" },
    rename = { key = code_key("r"), desc = "Rename current symbol" },
    search = { key = code_key("f"), desc = "LSP finder" },
    definition = { key = code_key("d"), desc = "Preview definition of current symbol" },
    hover_doc = { key = "K", desc = "Display hover documentation" },
    outline = { key = code_key("o"), desc = "Display outline symbols" },
    signature_help = { key = code_key("s"), desc = "Display signature of the current function" },
    diagnostic = {
      previous = { key = code_key("k"), desc = "Go to previous diagnostic" },
      next = { key = code_key("j"), desc = "Go to next diagnostic" },
      -- "h" for "Health"
      cursor = { key = code_key("h;"), desc = "Display diagnostic under the cursor" },
      line = { key = code_key("hl"), desc = "Display diagnostic for the current line" },
    },
  },
  code = {
    swap_prev_arg = { key = code_key("S"), desc = "Swap with previous argument" },
    swap_next_arg = { key = code_key("s"), desc = "Swap with next argument" },
  },
}

return M

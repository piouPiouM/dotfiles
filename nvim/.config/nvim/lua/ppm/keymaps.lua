local M = {
  open = "o",
  split = "s",
  vsplit = "v",
  tabe = "t",
  scroll_down = "<C-d>",
  scroll_up = "<C-u>",
}

M.completion = {
  complete = "<C-Space>",
  escape = "<C-e>"
}

M.search = {
  buffer = { key = "<leader>b", desc = "Search buffers" },
  oldfile = { key = "<leader>m", desc = "Search recent files (MRU)" },
  file = { key = "<leader>p", desc = "Search files" },
  file_all = { key = "<leader>fa", desc = "Search files without any restriction" },
  file_cwd = { key = "<leader><Space>", desc = "Search files in current directory" },
  git_file = { key = "<leader>s", desc = "Search files in git repository" },
  grep = { key = "<leader>fg", desc = "Live grep" },
  grep_cursor = { key = "<leader>f;", desc = "Search word under the cursor" },
  help_tags = { key = "<leader>H", desc = "Search in Neovim help" },
  resume = { key = "<leader>r", desc = "Resume last search" },
  tree_reveal = { key = "<leader>R", desc = "Reaveal current file in file browser" },
  tree_reveal_cursor = {
    key = "<leader>;",
    desc = "Reveal file under the cursor in file browser",
  },
}

M.lsp = {
  codeaction = { key = "<leader>ga", desc = "Display code actions" },
  rename = { key = "<leader>gr", desc = "Rename current symbol" },
  search = { key = "<leader>gf", desc = "LSP finder" },
  definition = { key = "<leader>gd", desc = "Preview definition of current symbol" },
  hover_doc = { key = "K", desc = "Display hover documentation" },
  outline = { key = "<leader>go", desc = "Display outline symbols" },
  signature_help = { key = "<leader>gs", desc = "Display signature of the current function" },
  diagnostic = {
    previous = { key = "<leader>gk", desc = "Go to previous diagnostic" },
    next = { key = "<leader>gj", desc = "Go to next diagnostic" },
    -- "h" for "Health"
    cursor = { key = "<leader>gh;", desc = "Display diagnostic under the cursor" },
    line = { key = "<leader>ghl", desc = "Display diagnostic for the current line" },
  },
}

M.code = {
  swap_prev_arg = { key = "<leader>gS", desc = "Swap with previous argument" },
  swap_next_arg = { key = "<leader>gs", desc = "Swap with next argument" },
}

M.surround = {
  {
    '<leader>"',
    'siw"',
    mode = { "n", "v" },
    desc = "Surround word with double quotes",
  },
  {
    "<leader>'",
    "siw'",
    mode = { "n", "v" },
    desc = "Surround word with single quotes",
  },
}

M.Ctrl = function(key)
  return "<C-" .. key .. ">"
end

return M

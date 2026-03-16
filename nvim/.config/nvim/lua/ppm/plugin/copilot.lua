require("copilot").setup({
  copilot_model = nil,
  copilot_node_command = vim.fn.expand("$HOME/.local/bin/n/n/versions/node/24.10.0/bin/node"),
  suggestion = { enabled = false },
  nes = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    yaml = true,
    markdown = true,
    gitcommit = true,
  },
  should_attach = function(_, bufname)
    if string.match(bufname, "%.env.*") then
      return false
    end

    return true
  end,
})
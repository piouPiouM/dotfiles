local M = {}

M.opts = {
  keymaps = {
    close = { n = "<C-c>", i = "<C-c>" },
  },
}

M.keys = {
  {
    "<leader>fr",
    function()
      require('grug-far').open()
    end,
    desc = "Find and replace (ripgrep)",
  },
  {
    "<leader>fR",
    function()
      require('grug-far').open({
        engine = 'astgrep',
      })
    end,
    desc = "Find and replace (ast-grep)",
  },
  {
    "<leader>fr",
    function()
      require('grug-far').with_visual_selection()
    end,
    desc = "Find and replace (ripgrep)",
    mode = "v",
  },
  {
    "<leader>fR",
    function()
      require('grug-far').with_visual_selection({
        engine = 'astgrep',
      })
    end,
    desc = "Find and replace (ast-grep)",
    mode = "v",
  },
}

return M

vim.cmd([[let &rtp.=','.getcwd()]])

vim.cmd(string.format("set rtp+=%s/lazy/plenary.nvim", vim.fn.stdpath("data")))

-- Set up 'plenary' only when calling headless Neovim (like with `make test-one`)
if #vim.api.nvim_list_uis() == 0 then
  vim.cmd([[runtime! tests/minimal_init.vim]])
end

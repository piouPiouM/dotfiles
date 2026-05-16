return {
  { "wincent/vim-docvim",     ft = "vim" },
  { "jxnblk/vim-mdx-js",      ft = "markdown.mdx" },
  { "fladson/vim-kitty",      ft = "kitty" },
  { "bfontaine/Brewfile.vim", ft = "brewfile" },
  {
    'alker0/chezmoi.vim',
    lazy = false,
    init = function()
      -- This option is required.
      vim.g['chezmoi#use_tmp_buffer'] = true
      -- add other options here if needed.
    end,
  },
}

local config = require("ppm.utils").lazy_config

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-textsubjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    config = config("treesitter"),
  },

  {
    "virchau13/tree-sitter-astro",
    ft = "astro",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {
        '<leader>jj',
        function() require('treesj').toggle() end,
        { desc = 'Toggle splitting/joining blocks of code' },
      },
      {
        '<leader>jm',
        function() require('treesj').join() end,
        { desc = 'Merge (join) blocks of code' },
      },
      {
        '<leader>js',
        function() require('treesj').split() end,
        { desc = 'Split blocks of code' },
      },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 240,
    },
  }
}
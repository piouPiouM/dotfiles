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
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>jj",
        function() require("treesj").toggle() end,
        { desc = "Toggle splitting/joining blocks of code" },
      },
      {
        "<leader>jm",
        function() require("treesj").join() end,
        { desc = "Merge (join) blocks of code" },
      },
      {
        "<leader>js",
        function() require("treesj").split() end,
        { desc = "Split blocks of code" },
      },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 240,
    },
  },
}
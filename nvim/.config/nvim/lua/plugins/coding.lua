local config = require("ppm.utils").lazy_config

return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.list = true
    end,
    main = "ibl",
    opts = {
      exclude = {
        filetypes = { "Trouble" },
        buftypes = {
          "alpha",
          "fzf",
          "help",
          "lazy",
          "lazyterm",
          "lspsagaoutline",
          "neo-tree",
          "notify",
          "startify",
          "toggleterm",
          "trouble",
        },
      },
      scope = {
        show_start = false,
      }
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    event = "VeryLazy",
  },

  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },

  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
  },

  {
    "b0o/schemastore.nvim",
    event = "VeryLazy",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "ray-x/cmp-treesitter",
      "f3fora/cmp-spell",
    },
    event = "InsertEnter",
    config = config("cmp"),
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      numhl = true
    },
    event = "VeryLazy"
  },
}

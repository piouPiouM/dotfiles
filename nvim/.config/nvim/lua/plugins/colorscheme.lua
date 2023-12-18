return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme github_dark]])
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      background = {
        light = "latte",
        dark = "mocha",
      },
      term_colors = true,
      integrations = {
        alpha = true,
        barbecue = false,
        cmp = true,
        dashboard = false,
        fidget = true,
        gitsigns = true,
        leap = true,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        neotree = true,
        nvimtree = false,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ts_rainbow = false,
        ts_rainbow2 = false,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = false },
      },
    },
  },

  {
    "shaunsingh/nord.nvim",
    init = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_cursorline_transparent = true
      vim.g.nord_italic = true
    end
  },

  {
    "andersevenrud/nordic.nvim",
    opts = {
      underline_option = 'undercurl',
      italic = true,
      italic_comments = true,
      minimal_mode = false,
      alternate_backgrounds = false
    },
    config = function(_, opts)
      require('nordic').colorscheme(opts)
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = { dim_inactive = true }
    },
    build = ":NightfoxCompile",
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "moon",
      dim_nc_background = true,
    },
  },

  { "ramojus/mellifluous.nvim" },
}

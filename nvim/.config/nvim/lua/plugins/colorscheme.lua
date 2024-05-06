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
    lazy = false,
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
    end,
    lazy = false,
  },

  {
    "andersevenrud/nordic.nvim",
    enabled = false,
    lazy = false,
    name = 'nordic-frost',
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
    lazy = false,
    opts = {
      options = { dim_inactive = true }
    },
    build = {
      ":NightfoxCompile",
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/carbonfox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Carbonfox.conf',
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/dawnfox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Dawnfox.conf',
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/dayfox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Dayfox.conf',
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/duskfox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Duskfox.conf',
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/nightfox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Nightfox.conf',
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/nordfox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Nordfox.conf',
      'cp $XDG_DATA_HOME/nvim/lazy/nightfox.nvim/extra/terafox/kitty.conf $XDG_CONFIG_HOME/kitty/themes/Terafox.conf',
    },
  },

  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    opts = {
      dark_variant = "moon",
      dim_nc_background = true,
    },
  },

  {
    "ramojus/mellifluous.nvim",
    lazy = false,
  },

  {
    "miikanissi/modus-themes.nvim",
    build = 'cp $XDG_DATA_HOME/nvim/lazy/modus-themes.nvim/extras/kitty/*.conf $XDG_CONFIG_HOME/kitty/themes/',
    lazy = false,
    opts = {
      transparent = false,
      dim_inactive = true,
    },
  },

  {
    "rebelot/kanagawa.nvim",
    build = 'cp $XDG_DATA_HOME/nvim/lazy/kanagawa.nvim/extras/kanagawa*.conf $XDG_CONFIG_HOME/kitty/themes/',
    lazy = false,
  },
}

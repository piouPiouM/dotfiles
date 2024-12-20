local config = require("ppm.utils").lazy_config
local colorizer_ft = { "css", "scss", "sass", "less", "javascript", "typescript", "vim", "lua", "markdown" }

return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = { filetypes = colorizer_ft },
    ft = colorizer_ft,
    cmd = "ColorizerToggle",
  },

  -- Adds text objects for word-based columns in Vim
  -- aV
  -- iV
  -- aV
  -- iV
  {
    "rhysd/textobj-word-column.vim",
    dependencies = "kana/vim-textobj-user",
    lazy = false,
  },

  -- a_
  -- i_
  {
    "lucapette/vim-textobj-underscore",
    dependencies = "kana/vim-textobj-user",
    lazy = false,
  },

  -- Provides two text objects: ix and ax
  -- ix works with the_inner_attribute, with no surrounding whitespace
  -- ax includes the whitespace before the attribute
  {
    "whatyouhide/vim-textobj-xmlattr",
    dependencies = "kana/vim-textobj-user",
    lazy = false,
  },

  -- Provides two text objects: i, and a,
  -- i, to inner parameter object
  -- a, to a parameter object including whitespaces and comma
  -- i2, is similar to a, except trailing whitespace characters (especially for first parameter)
  {
    "sgur/vim-textobj-parameter",
    dependencies = "kana/vim-textobj-user",
    lazy = false,
  },

  {
    "monaqa/dial.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = config("dial_setup"),
    config = config("dial"),
    event = "VeryLazy",
  },

  {
    'echasnovski/mini.surround',
    event = "VeryLazy",
    opts = {
      silent = true,
    },
    version = false, -- `main` branch
  },

  {
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    event = "VeryLazy"
  },
}

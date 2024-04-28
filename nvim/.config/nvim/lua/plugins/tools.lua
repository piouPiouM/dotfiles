local config = require("ppm.utils").lazy_config
local colorizer_ft = { "css", "scss", "sass", "less", "javascript", "typescript", "vim", "lua", "markdown" }

return {
  {
    "NvChad/nvim-colorizer.lua",
    opts = { filetypes = colorizer_ft },
    ft = colorizer_ft,
    cmd = "ColorizerToggle",
  },

  {
    "kana/vim-textobj-user",
    dependencies = {
      -- Adds text objects for word-based columns in Vim
      -- ac
      -- ic
      -- aC
      -- iC
      -- TODO: to replace with rhysd/vim-textobj-word-column
      "coderifous/textobj-word-column.vim",

      -- a_
      -- i_
      "lucapette/vim-textobj-underscore",

      -- Provides two text objects: ix and ax
      -- ix works with the inner attribute, with no surrounding whitespace
      -- ax includes the whitespace before the attribute
      "whatyouhide/vim-textobj-xmlattr",

      -- Provides two text objects: i, and a,
      -- i, to inner parameter object
      -- a, to a parameter object including whitespaces and comma
      -- i2, is similar to a, except trailing whitespace characters (especially for first parameter)
      "sgur/vim-textobj-parameter",
    },
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
    cmd = "UndotreeToggle"
  },
}

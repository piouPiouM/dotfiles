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
    "kylechui/nvim-surround",
    event = "VeryLazy"
  },

  {
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  {
    "tpope/vim-eunuch",
    cmd = {
      "Cfind",       -- Run find and load the results into the quickfix list.
      "Lfind",       -- Like above, but use the location list.
      "Clocate",     -- Run locate and load the results into the quickfix list.
      "Llocate",     -- Like above, but use the location list.
      "Chmod",       -- Change the permissions of the current file
      "Copy",
      "Delete",      -- Delete a buffer and the file on disk simultaneously
      "Duplicate",
      "Mkdir",       -- Create a directory, defaulting to the parent of the current file
      "Move",        -- Rename a buffer and the file on disk simultaneously
      "Remove",      -- Delete a file on disk without E211: File no longer available
      "Rename",      -- LikeMove,", -but relative to the current file's containing directory
      "SudoEdit",    -- Edit a privileged file with sudo
      "SudoWrite",   -- Write a privileged file with sudo
      "Unlink",      -- LikeRemove,", -but keeps the now empty buffer
      "Wall",        -- Write every open window. Handy for kicking off tools like guard
    },
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle"
  },
}
local config = require("ppm.utils").lazy_config

return {
  {
    "ibhagwan/fzf-lua",
    init = config("fzf-lua.setup"),
    config = config("fzf-lua"),
    cmd = "FzfLua",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim",
    },
    cmd = "Neotree",
    config = config("neotree"),
    init = config("neotree_setup"),
  },

  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      }
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
    config = config("telescope"),
    cmd = "Telescope",
  },

  -- s{c1}{c2}
  -- S{c1}{c2}
  -- gs{c1}{c2}
  {
    "ggandor/leap.nvim",
    config = function(plugin)
      require(plugin.name).add_default_mappings()
    end,
    dependencies = { "ggandor/flit.nvim", "tpope/vim-repeat" },
    event = "VeryLazy",
    name = "leap",
  },
}

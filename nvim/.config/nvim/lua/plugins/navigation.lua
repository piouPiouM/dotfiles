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
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim",
    },
    init = config("neotree_setup"),
    opts = {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "qf",
        "TelescopePrompt",
        "lspsagaoutline",
      },
      filesystem = {
        filtered_items = {
          hide_by_name = { "node_modules" },
          always_show = { ".config" },
          never_show = { ".DS_Store" },
        },
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        window = {
          mappings = { ["h"] = "toggle_hidden" },
        },
      },
    },
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

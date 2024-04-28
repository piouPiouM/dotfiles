local config = require("ppm.utils").lazy_config

return {
  {
    "ibhagwan/fzf-lua",
    init = config("fzf-lua.setup"),
    opts = require("ppm.plugin.fzf-lua"),
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
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      }
    },
  },

  {
    --- Used for `telescope.utils.transform_path()`.
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
    config = config("telescope"),
    cmd = "Telescope",
  },

  {
    "woosaaahh/sj.nvim",
    opts = {
      pattern_type = "vim_very_magic",
      prompt_prefix = " ",
      keymaps = {
        send_to_qflist = "<C-q>",
      },
    },
    keys = function (plugin)
      local sj = require(plugin.name)

      return {
        { "Z", sj.run, mode = "n" },
        { "<localleader>Z", function() sj.run({ select_window = true }) end, mode = "n" },
      }
    end,
    event = "VeryLazy",
    name = "sj",
  },
}
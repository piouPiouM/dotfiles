local config = require("ppm.utils").lazy_config
local k = require("ppm.keymaps");

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
    keys = {
      { "-", "<CMD>Oil<CR>", { desc = "Browse parent directory" } },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      keymaps = {
        [k.Ctrl(k.vsplit)] = "actions.select_vsplit",
        [k.Ctrl(k.split)] = "actions.select_split",
      },
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
    "arsham/listish.nvim",
    dependencies = {
      "arsham/arshlib.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      theme_list = false,
      signs = {
        loclist = "",
        qflist = "",
        priority = 10,
      },
      quickfix = {
        open = false,
        on_cursor = "<leader>qa", -- add current position to the list
        add_note = "<leader>qn",  -- add current position with your note to the list
        clear = "<leader>qd",     -- clear all items
        close = false,
        next = "]q",
        prev = "[q",
      },
      loclist = {
        open = false,
        on_cursor = "<leader>la",
        add_note = "<leader>ln",
        clear = "<leader>ld",
        close = false,
        next = "]l",
        prev = "[l",
      },
    },
    keys = {
      "<leader>qa", -- add current position to the quicklist
      "<leader>qn", -- add current position with your note to the quicklist
      "<leader>la", -- add current position to the loclist
      "<leader>ln", -- add current position with your note to the loclist
    },
    ft = { "qf" },
  },

  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    keys = {
      {
        "<leader>qq",
        function() require('quicker').toggle() end,
        { desc = "Toggle the quickfix list" },
      },
      {
        "<leader>ll",
        function() require('quicker').toggle({ loclist = true }) end,
        { desc = "Toggle the loclist list" },
      },
    },
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      type_icons = {
        E = "󰅚 ",
        W = "󰀪 ",
        I = " ",
        N = " ",
        H = " ",
      },
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },

  {
    "woosaaahh/sj.nvim",
    opts = {
      pattern_type = "vim_very_magic",
      prompt_prefix = "󰆷 ",
      keymaps = {
        send_to_qflist = "<C-q>",
      },
    },
    keys = function(plugin)
      local sj = require(plugin.name)

      return {
        { "!",     sj.run,                                          mode = "n", desc = "Quick search & jump" },
        { "<A-!>", function() sj.run({ select_window = true }) end, mode = "n", desc = "Quick search & jump in all windows" },
      }
    end,
    event = "VeryLazy",
    name = "sj",
  },

  {
    'skardyy/neo-img',
    event = "VeryLazy",
    -- cond = function() return vim.fn.has("macunix") ~= 1 end,
    opts = {
      backend = "kitty",
      ttyimg = "global",
    }
  }
}

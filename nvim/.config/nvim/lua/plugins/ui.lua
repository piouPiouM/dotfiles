local config = require("ppm.utils").lazy_config

return {
  {
    "nvim-tree/nvim-web-devicons",
    opts = { default = true },
  },

  { "mortepau/codicons.nvim" },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = function()
      return require("alpha.themes.theta").config
    end,
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>L",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = require("ppm.plugin.noice"),
  },

  {
    "nvim-lualine/lualine.nvim",
    config = config("lualine"),
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },

  {
    "szw/vim-maximizer",
    keys = { { "<F3>", "<cmd>MaximizerToggle", desc = "Zoom" } },
  },
}

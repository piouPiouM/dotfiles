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

  { "rcarriga/nvim-notify" },

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

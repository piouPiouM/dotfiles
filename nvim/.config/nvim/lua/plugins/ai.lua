local config = require("ppm.utils").lazy_config

return {
  {
    "zbirenbaum/copilot-cmp",
    config = config("copilot_cmp"),
    dependencies = {
      "hrsh7th/nvim-cmp",
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = config("copilot"),
      },
      { 'AndreM222/copilot-lualine' }
    },
  },

  --[[ {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot-cmp" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    keys = {
      {
        "<Leader>ch",
        ":'<,'>CopilotChat<CR>",
        mode = { "v" },
        desc = "Copilot Chat Selection",
      },
      {
        "<Leader>ch",
        ":CopilotChatToggle<CR>",
        mode = { "n" },
        desc = "Toggle Copilot Chat",
      },
    },
  }, ]]

  -- vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionActions",
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
    end,
    -- keys = {
    --   {
    --     "<Leader>a",
    --     ":'<,'>CodeCompanionActions<CR>",
    --     mode = { "n", "v" },
    --     desc = "Toggle CodeCompanion actions palette",
    --   },
    --   {
    --     "<Leader>cc",
    --     "<CMD>CodeCompanionChat Toggle<CR>",
    --     mode = { "n" },
    --     desc = "Toggle AI Chat",
    --   },
    --   {
    --     "<Leader>c+",
    --     ":'<,'>CodeCompanionChat Add<CR>",
    --     mode = { "v" },
    --     desc = "Add visually selected chat to the current chat buffer",
    --   },
    -- },
    config = config("codecompanion"),
    keys = require("ppm.plugin.codecompanion.keys"),
  },
}
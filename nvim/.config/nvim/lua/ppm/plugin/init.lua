vim.cmd("packadd packer.nvim")

require("packer.luarocks").install_commands()

return require("packer").startup({
  function(use, use_rocks)
    local ft = require("ppm.filetype")
    local config = function(name) return string.format("require('ppm.plugin.%s')", name) end
    local simple_setup = function(name) return string.format("require('%s').setup({})", name) end

    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"

    use_rocks {
      "fun",   -- functional programming library
      "moses", -- functional programming library
    }

    use { "nvim-lua/plenary.nvim" }

    -- TODO: use https://github.com/folke/neoconf.nvim instead
    use { "embear/vim-localvimrc", config = config("localvimrc"), disable = true }

    --[[ Interface ]]
    -- Icons
    use {
      {
        "kyazdani42/nvim-web-devicons",
        config = config("web-devicons"),
        module = "nvim-web-devicons",
      },
      "mortepau/codicons.nvim",
    }

    -- Friendly welcome screen
    use {
      "goolord/alpha-nvim",
      requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
      config = config("alpha"),

    }

    -- Notification
    use { "rcarriga/nvim-notify", config = config("notify") }

    -- StatusLine
    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      },
      config = config("lualine"),
    }

    -- File tree
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      setup = config("neotree_setup"),
      config = config("neotree"),
      cmd = { "Neotree", "NeoTreeFloatToggle", "NeoTreeRevealToggle" },
    }
    use { "stevearc/oil.nvim", config = config("oil") }

    -- Maximize or restore windows.
    use { "szw/vim-maximizer", cmd = "MaximizerToggle", keys = { { "n", "<F3>" } } }

    -- Editor
    use {
      {
        "nvim-treesitter/nvim-treesitter",
        requires = {
          "RRethy/nvim-treesitter-textsubjects",
          "JoosepAlviste/nvim-ts-context-commentstring",
          "windwp/nvim-ts-autotag",
        },
        run = ":TSUpdate",
        config = config("treesitter"),
      },
      { "virchau13/tree-sitter-astro", opt = true, ft = "astro" },
    }

    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
    }

    use {
      "nvim-treesitter/nvim-treesitter-context",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = "User ActuallyEditing",
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      module = "ibl",
      config = config("indent-blankline"),
      event = "User ActuallyEditing",
    }

    use {
      "numToStr/Comment.nvim",
      requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
      config = config("comment"),
      event = "User ActuallyEditing",
    }

    use {
      "NvChad/nvim-colorizer.lua",
      config = config("colorizer"),
      ft = { "css", "scss", "sass", "less", "javascript", "typescript", "vim", "lua", "markdown" },
      cmd = "ColorizerToggle",
    }

    -- Fuzzy Finder
    use {
      "ibhagwan/fzf-lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      setup = config("fzf-lua/setup"),
      config = config("fzf-lua"),
      cmd = "FzfLua",
      module = "fzf-lua",
    }

    use {
      {
        "nvim-telescope/telescope.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-lua/popup.nvim",
        },
        wants = {
          "plenary.nvim",
          "popup.nvim",
        },
        config = config("telescope"),
        cmd = "Telescope",
        module = "telescope",
      },
      { "nvim-lua/popup.nvim", opt = true },
    }

    use {
      { "rafamadriz/friendly-snippets", opt = true },
      { "L3MON4D3/LuaSnip",             opt = true, wants = "friendly-snippets" },
    }

    -- Completion
    use { "b0o/schemastore.nvim", ft = { "json", "yaml" } }
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp",                event = "User ActuallyEditing" },
        { "hrsh7th/cmp-nvim-lua",                after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer",                  after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline",                 after = "nvim-cmp" },
        { "FelipeLema/cmp-async-path",           after = "nvim-cmp" },
        { "hrsh7th/cmp-calc",                    after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip",            after = { "nvim-cmp", "LuaSnip" } },
        { "ray-x/cmp-treesitter",                after = "nvim-cmp" },
        { "f3fora/cmp-spell",                    after = "nvim-cmp" },
      },
      event = "InsertEnter",
      config = config("cmp"),
      wants = { "LuaSnip" },
    }

    -- Language Server Protocol
    use {
      {
        "folke/neodev.nvim",
        event = "User ActuallyEditing",
      },
      {
        "j-hui/fidget.nvim",
        event = "User ActuallyEditing",
        branch = "legacy",
        config = config("fidget"),
      },
      {
        "neovim/nvim-lspconfig",
        config = config("lsp"),
        wants = "neodev.nvim",
        event = "User ActuallyEditing",
      },
      {
        "nvimdev/lspsaga.nvim",
        branch = "main",
        requires = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
        event = "LspAttach",
        setup = config("lspsaga_setup"),
        config = config("lspsaga"),
        after = "nvim-lspconfig",
      },
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = config("lsp_lines"),
        event = "LspAttach",
        after = "nvim-lspconfig",
      },
      {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        config = simple_setup("trouble")
      },
      {
        "jose-elias-alvarez/typescript.nvim",
        requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
        config = config("typescript"),
        ft = ft.typescript,
      },
      { "marilari88/twoslash-queries.nvim", config = config("twoslash-queries"), ft = ft.typescript },
    }

    -- Documentation
    use {
      "danymat/neogen",
      config = simple_setup("neogen"),
      requires = "nvim-treesitter/nvim-treesitter",
    }

    -- Syntax
    use {
      { "wincent/vim-docvim",           ft = "vim" },
      { "jxnblk/vim-mdx-js",            ft = "markdown.mdx" },
      { "fladson/vim-kitty",            ft = "kitty" },
      { "terminalnode/sway-vim-syntax", ft = "swayconfig" },
      { "bfontaine/Brewfile.vim",       ft = "brewfile" },
    }

    -- Text manipulation
    use {
      "kana/vim-textobj-user",
      requires = {
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
    }

    use {
      "monaqa/dial.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      setup = config("dial_setup"),
      config = config("dial"),
      -- keys = { "<C-a>", "<C-x>", "g<C-a>", "g<C-x>" },
      -- cmd = { "DialIncrement" },
      -- module = "dial.map",
      event = "User ActuallyEditing",
    }

    use { "kylechui/nvim-surround", config = config("nvim-surround"),
      event = "User ActuallyEditing" }

    -- s{c1}{c2}
    -- S{c1}{c2}
    -- gs{c1}{c2}
    -- Note: do not lazy-load it or precise a dependency that is lazy-loaded.
    use {
      "ggandor/leap.nvim",
      config = config("leap"),
      requires = { { "ggandor/flit.nvim", config = simple_setup("flit") } },
    }

    -- TODO consider wellle/targets.vim

    -- Git
    use { "lewis6991/gitsigns.nvim", config = config("gitsigns"), event = "User ActuallyEditing" }

    -- Utils
    use { "tpope/vim-repeat", event = "User ActuallyEditing" }
    use {
      "tpope/vim-eunuch",
      cmd = {
        "Cfind",     -- Run find and load the results into the quickfix list.
        "Lfind",     -- Like above, but use the location list.
        "Clocate",   -- Run locate and load the results into the quickfix list.
        "Llocate",   -- Like above, but use the location list.
        "Chmod",     -- Change the permissions of the current file
        "Copy",
        "Delete",    -- Delete a buffer and the file on disk simultaneously
        "Duplicate",
        "Mkdir",     -- Create a directory, defaulting to the parent of the current file
        "Move",      -- Rename a buffer and the file on disk simultaneously
        "Remove",    -- Delete a file on disk without E211: File no longer available
        "Rename",    -- LikeMove,", -but relative to the current file's containing directory
        "SudoEdit",  -- Edit a privileged file with sudo
        "SudoWrite", -- Write a privileged file with sudo
        "Unlink",    -- LikeRemove,", -but keeps the now empty buffer
        "Wall",      -- Write every open window. Handy for kicking off tools like guard
      },
    }

    use { "mbbill/undotree", cmd = "UndotreeToggle" }

    -- use "wincent/pinnacle"

    -- Colorscheme
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function() require("ppm.colorscheme.catppuccin").setup() end,
    }
    use { "shaunsingh/nord.nvim", config = function() require("ppm.colorscheme.nord").setup() end }
    use {
      "maaslalani/nordbuddy",
      config = function() require("ppm.colorscheme.nordbuddy").setup() end,
    }
    use {
      "EdenEast/nightfox.nvim",
      config = function() require("ppm.colorscheme.nightfox").setup() end,
      run = ":NightfoxCompile",
    }
    use {
      "rose-pine/neovim",
      as = "rose-pine",
      tag = "v1.*",
      config = function() require("ppm.colorscheme.rose-pine").setup() end,
    }
    use {
      "ramojus/mellifluous.nvim",
      config = simple_setup("mellifluous")
    }
    use { "projekt0n/github-nvim-theme" }
  end,
  config = {
    display = {
      compact = true,
      open_fn = function() return require("packer.util").float({ border = "single" }) end,
    },
    luarocks = { python_cmd = "python3" },
  },
})

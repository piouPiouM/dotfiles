vim.cmd("packadd packer.nvim")

require("packer.luarocks").install_commands()

return require("packer").startup({
  function(use, use_rocks)
    local ft = require("ppm.filetype")
    local config = function(name) return string.format("require('ppm.plugin.%s')", name) end

    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"

    use_rocks {
      "fun",   -- functional programming library
      "moses", -- functional programming library
      { "luaformatter", server = "https://luarocks.org/dev" },
    }

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
    use {
      "rcarriga/nvim-notify",
      config = config("notify"),
    }

    -- StatusLine
    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "SmiteshP/nvim-navic",
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
      "nvim-treesitter/nvim-treesitter-context",
      requires = { "nvim-treesitter/nvim-treesitter" },
      event = "User ActuallyEditing",
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
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
      {
        "nvim-telescope/telescope.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-lua/popup.nvim",
          "nvim-telescope/telescope-file-browser.nvim",
          "nvim-telescope/telescope-fzf-native.nvim",
          "nvim-telescope/telescope-live-grep-args.nvim",
          "nvim-telescope/telescope-symbols.nvim",
          "nvim-telescope/telescope-ui-select.nvim",
        },
        wants = {
          "plenary.nvim",
          "popup.nvim",
          "telescope-file-browser.nvim",
          "telescope-fzf-native.nvim",
          "telescope-live-grep-args.nvim",
          "telescope-symbols.nvim",
          "telescope-ui-select.nvim",
        },
        setup = config("telescope_setup"),
        config = config("telescope"),
        cmd = "Telescope",
        module = "telescope",
      },
      { "nvim-lua/plenary.nvim",                        opt = true },
      { "nvim-lua/popup.nvim",                          opt = true },
      { "kkharji/sqlite.lua",                           opt = true },
      { "nvim-telescope/telescope-file-browser.nvim",   opt = true },
      { "nvim-telescope/telescope-fzf-native.nvim",     run = "make", opt = true },
      { "nvim-telescope/telescope-live-grep-args.nvim", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
      { "nvim-telescope/telescope-ui-select.nvim", opt = true },
    }

    -- use { "camspiers/snap", rocks = { "fzy" } }
    -- The project seems to be on pause :/
    -- use { "camspiers/snap", config = config("snap") }

    use { "onsails/lspkind-nvim", opt = true }

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
      },
      event = "InsertEnter",
      config = config("cmp"),
      wants = { "lspkind-nvim", "LuaSnip" },
    }

    -- Language Server Protocol
    use {
      { "folke/neodev.nvim", event = "User ActuallyEditing" },
      { "j-hui/fidget.nvim", config = config("fidget"),     event = "User ActuallyEditing" },
      {
        "neovim/nvim-lspconfig",
        config = config("lsp"),
        wants = "neodev.nvim",
        event = "User ActuallyEditing",
      },
      {
        "nvimdev/lspsaga.nvim",
        branch = "main",
        requires = {
          "nvim-tree/nvim-web-devicons",
          "nvim-treesitter/nvim-treesitter"
        },
        event = "LspAttach",
        setup = config("lspsaga_setup"),
        config = config("lspsaga"),
        after = "nvim-lspconfig",
      },
      {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        config = function() require("trouble").setup {} end,
      },
      {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
        module = "nvim-navic",
        config = config("navic"),
      },
      {
        "jose-elias-alvarez/typescript.nvim",
        requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
        config = config("typescript"),
        ft = ft.typescript,
      },
    }

    -- Syntax
    use {
      { "wincent/vim-docvim",           ft = "vim" },
      { "jxnblk/vim-mdx-js",            ft = "markdown.mdx" },
      { "fladson/vim-kitty",            ft = "kitty" },
      { "terminalnode/sway-vim-syntax", ft = "swayconfig" },
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
  end,
  config = {
    display = {
      compact = true,
      open_fn = function() return require("packer.util").float({ border = "single" }) end,
    },
    luarocks = { python_cmd = "python3" },
  },
})

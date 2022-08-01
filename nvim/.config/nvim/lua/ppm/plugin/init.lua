vim.cmd("packadd packer.nvim")

return require("packer").startup({
  function(use)
    local config = function(name) return string.format("require('ppm.plugin.%s')", name) end

    use "wbthomason/packer.nvim"
    use "lewis6991/impatient.nvim"
    use { "embear/vim-localvimrc", config = config("localvimrc") }

    -- Icons
    use {
      { "kyazdani42/nvim-web-devicons", config = config("web-devicons") },
      "mortepau/codicons.nvim",
    }

    -- Friendly welcome screen
    use {
      "goolord/alpha-nvim",
      requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
      config = config("alpha"),
    }

    use { "nvim-lualine/lualine.nvim", config = config("lualine") }

    -- File tree
    use {
      -- TODO: replace with nvim-neo-tree/neo-tree.nvim
      { "scrooloose/nerdtree", cmd = "NERDTreeToggle" },
      { "tiagofumo/vim-nerdtree-syntax-highlight", after = "nerdtree", opt = true },
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
        },
        run = ":TSUpdate",
        config = config("treesitter"),
      },
      { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    }

    use "preservim/nerdcommenter" -- TODO: replace with numToStr/Comment.nvim
    use {
      "RRethy/vim-hexokinase",
      run = "make hexokinase",
      config = config("hexokinase"),
      ft = { "css", "scss", "sass", "less", "javascript", "typescript", "vim", "lua", "markdown" },
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
      { "nvim-lua/plenary.nvim", opt = true },
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-telescope/telescope-file-browser.nvim", opt = true },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
      { "nvim-telescope/telescope-live-grep-args.nvim", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
      { "nvim-telescope/telescope-ui-select.nvim", opt = true },
    }

    -- Completion
    use { "b0o/schemastore.nvim", module = "schemastore" }
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "L3MON4D3/LuaSnip",
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-calc", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
        "rafamadriz/friendly-snippets",
      },
      event = "InsertEnter *",
      config = config("cmp"),
    }

    -- Language Server Protocol
    use {
      { "j-hui/fidget.nvim", config = config("fidget") },
      { "neovim/nvim-lspconfig", config = config("lsp") },
      "onsails/lspkind-nvim",
      { "simrat39/symbols-outline.nvim", cmd = { "SymbolsOutline", "SymbolsOutlineOpen" } },
      {
        "kosayoda/nvim-lightbulb",
        requires = "antoinemadec/FixCursorHold.nvim",
        setup = config("lightbulb_setup"),
        config = config("lightbulb"),
        module = "ppm.plugin.lightbulb",
      },
      {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        module = "trouble",
        config = function() require("trouble").setup {} end,
      },
      {
        "rmagatti/goto-preview",
        -- after = "telescope",
        keys = {
          "gpd", -- Preview definition
          "gpi", -- Preview inmplementation
          "gpr", -- Preview references in Telescope
          "gP", -- Close all preview floating windows
        },
        config = function() require("goto-preview").setup { default_mappings = true } end,
      },
      {
        -- TODO: archived project. Replaced by jose-elias-alvarez/typescript.nvim
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
        -- ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        cmd = {
          "TSLspOrganize",
          "TSLspOrganizeSync",
          "TSLspRenameFile",
          "TSLspImportAll",
          "TSLspImportCurrent",
          "TSLspInlayHints",
          "TSLspToggleInlayHints",
        },
        module = "cmp_nvim_lsp",
      },
    }

    -- Syntax
    use {
      { "editorconfig/editorconfig-vim", event = "InsertEnter *", config = config("editorconfig") },
      { "wincent/vim-docvim", ft = "vim" },
      { "jxnblk/vim-mdx-js", ft = "markdown.mdx" },
      { "fladson/vim-kitty", ft = "kitty" },
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

    -- TODO: may be replaced by monaqa/dial.nvim 🤔
    use {
      -- Increment/decrement dates, times
      { "tpope/vim-speeddating", keys = { { "n", "C-a" }, { "n", "C-x" } } },
      -- Switch text with predefined replacements
      { "AndrewRadev/switch.vim", cmd = "Switch", keys = { "n", "-" }, config = config("switch") },
    }

    use "tpope/vim-surround"

    -- TODO consider wellle/targets.vim
    -- TODO consider machakann/vim-sandwich

    -- Git
    use {
      "airblade/vim-gitgutter",
      { "rhysd/git-messenger.vim", keys = { { "n", "<leader>gm" } }, cmd = "GitMessenger" },
    }

    -- Utils
    use "tpope/vim-repeat"
    use {
      "tpope/vim-eunuch",
      cmd = {
        "Remove", -- Delete a buffer and the file on disk simultaneously
        "Unlink", -- LikeRemove,", -but keeps the now empty buffer
        "Move", -- Rename a buffer and the file on disk simultaneously
        "Rename", -- LikeMove,", -but relative to the current file's containing directory
        "Chmod", -- Change the permissions of the current file
        "Mkdir", -- Create a directory, defaulting to the parent of the current file
        "Find", -- Run find and load the results into the quickfix list
        "Locate", -- Run locate and load the results into the quickfix list
        "Wall", --  Write every open window. Handy for kicking off tools like guard
        "SudoWrite", -- Write a privileged file with sudo
        "SudoEdit", -- Edit a privileged file with sudo
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
  end,
  config = {
    display = { open_fn = function() return require("packer.util").float({ border = "single" }) end },
  },
})

local fn = vim.fn
local opt = vim.opt
local o = vim.o
local wo = vim.wo

o.hidden = true -- Don't require saving before editing another file.
o.swapfile = false
o.undofile = true;

-- Interface {{{1

o.mouse = "a"               -- Enable mouse support.
o.clipboard = "unnamedplus" -- TODO: check this for MacOS/Linux

-- Command bar {{{2

o.showcmd = true
o.cmdheight = 1    -- Height of the command bar.
o.showmode = false -- Hide mode line text since it's already in Lualine.
opt.shortmess:append("Ac")

if fn.has("nvim-0.7") then
  o.laststatus = 3 -- Global statusline
end

-- }}}2
-- Gutter {{{2

o.relativenumber = true -- Show relative line numbers...
o.number = true         -- ... but show the actual number for the current line.
o.signcolumn = "yes"    -- Prevents buffer moving when adding/deleting sign.

-- }}}2
-- Windows {{{2

o.equalalways = false
o.splitright = true -- Splitting windows at the right...
o.splitbelow = true -- ... bottom.

-- }}}2
-- }}}1
-- Editor {{{1

o.tabstop = 2                 -- A tab is 2 spaces.
o.shiftwidth = 2              -- Number of spaces to use for autoindenting.
o.softtabstop = 2             -- When hitting <BS>, pretend like a tab is removed, even if spaces.
o.expandtab = true            -- Expand tabs by default.

o.copyindent = true           -- Copy the previous indentation on autoindenting.
o.wrap = true                 -- Wrap lines.
o.joinspaces = false          -- Only insert 1 space
opt.formatoptions:append("12jp")
opt.nrformats:append("alpha") -- Single alphabetical characters will be incremented or decremented.
opt.diffopt:append({ "algorithm:patience" })

o.modeline = true
o.scrolloff = 10   -- Provide some context when editing.
o.showmatch = true -- Show matching brackets/parenthesis.
o.history = 300

opt.list = true -- Show invisible characters.
opt.listchars = { eol = "¬", extends = "❯", precedes = "❮", nbsp = "․", tab = "▸ " }
o.showbreak = "↪"
wo.fillchars = "eob:" -- Hide the end of buffer tilde.

-- Used by `gf` to follow ES6 import. `Ctrl-o` to come back.
opt.suffixesadd = { ".js", ".jsx", ".json", ".ts", ".tsx", ".tsx.styl", ".css", ".scss", ".sass" }

o.textwidth = 120
if fn.executable("par") then
  o.formatprg = string.format("par -w%dre", vim.api.nvim_get_option("textwidth"))
end

wo.foldminlines = 3
wo.foldmethod = "expr"
wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
wo.foldlevel = 10

-- }}}1
-- Search {{{1

o.ignorecase = true -- Ignore case when searching...
o.smartcase = true  -- ... except there is a capital letter in the query
o.magic = true      -- Set magic on, for regular expressions
o.gdefault = true   -- Apply global substitutions
o.incsearch = true  -- Makes search act like search in modern browsers
o.grepprg = "rg --vimgrep"

-- }}}1
-- Completion {{{1

o.infercase = true -- Ignore case on insert completion.

-- Better floating windows
o.pumblend = 17
o.wildmode = "longest:full"
o.wildoptions = "pum"

-- Ignore {{{2

-- Common temporary directories
opt.wildignore:append({ ".tmp", ".cache", ".vendors" })

-- LaTeX intermediate files
opt.wildignore:append({ "*.aux", "*.out", "*.toc" })

-- Compiled files
opt.wildignore:append({ "*.luac", "*.o", "*~", "*.obj", "*.exe", "*.dll", "*.manifest" })

-- Python files
opt.wildignore:append({ "*pycache*", "*.pyc", "*.pyo" })

-- Sass cache files
opt.wildignore:append({ "*.sassc", "*.scssc", ".sass-cache" })

-- SCM
opt.wildignore:append({ ".svn", ".git", ".gitkeep" })

opt.wildignore:append({
  ".bundle",   -- Ruby
  ".DS_Store", -- OSX
  "*.spl",     -- compiled spelling word lists
  "*.sw?",     -- Vim swap files
  "tags",      -- ctags stuff
})

-- }}}2

opt.completeopt:remove({ "preview" }) -- Disable Scratch window

-- }}}1
-- Speed up! {{{1

o.lazyredraw = true -- Do not redraw while running macros (much faster).
o.synmaxcol = 800   -- vs 3000 by default.
o.updatetime = 600  -- Smaller updatetime for CursorHold & CursorHoldI.
o.fsync = false     -- Let the OS decide when it's appropriate to flush the cache, rather than vim (much faster).

-- }}}1

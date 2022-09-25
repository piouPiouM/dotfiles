local fn = vim.fn
local opt = vim.opt
local wo = vim.wo

opt.hidden = true -- Don't require saving before editing another file.
opt.swapfile = false
opt.undofile = true;

-- Interface {{{1

opt.mouse = "a" -- Enable mouse support.
opt.clipboard = "unnamedplus" -- TODO: check this for MacOS/Linux

-- Command bar {{{2
--
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar.
opt.showmode = false -- Hide mode line text since it's already in Lualine.
opt.shortmess:append("Ac")

if fn.has("nvim-0.7") then
  opt.laststatus = 3 -- Global statusline
end

-- }}}2
-- Gutter {{{2

opt.relativenumber = true -- Show relative line numbers...
opt.number = true -- ... but show the actual number for the current line.
opt.signcolumn = "yes" -- Prevents buffer moving when adding/deleting sign.

-- }}}2
-- Windows {{{2

opt.equalalways = false
opt.splitright = true -- Splitting windows at the right...
opt.splitbelow = true -- ... bottom.

-- }}}2
-- }}}1
-- Editor {{{1

opt.tabstop = 2 -- A tab is 2 spaces.
opt.shiftwidth = 2 -- Number of spaces to use for autoindenting.
opt.softtabstop = 2 -- When hitting <BS>, pretend like a tab is removed, even if spaces.
opt.expandtab = true -- Expand tabs by default.

opt.copyindent = true -- Copy the previous indentation on autoindenting.
opt.wrap = true -- Wrap lines.
opt.joinspaces = false -- Only insert 1 space
opt.formatoptions:append("12jp")
opt.nrformats:append("alpha") -- Single alphabetical characters will be incremented or decremented.

opt.modeline = true
opt.scrolloff = 10 -- Provide some context when editing.
opt.showmatch = true -- Show matching brackets/parenthesis.
opt.history = 300

opt.list = true -- Show invisible characters.
opt.listchars = { eol = "¬", extends = "❯", precedes = "❮", nbsp = "․", tab = "▸ " }
opt.showbreak = "↪"
wo.fillchars = "eob: " -- Hide the end of buffer tilde.

-- Used by `gf` to follow ES6 import. `Ctrl-o` to come back.
opt.suffixesadd = { ".js", ".jsx", ".json", ".ts", ".tsx.styl", ".css", ".scss", ".sass" }

opt.textwidth = 120
if fn.executable("par") then
  opt.formatprg = string.format("par -w%dre", vim.api.nvim_get_option("textwidth"))
end

-- }}}1
-- Search {{{1

opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... except there is a capital letter in the query
opt.magic = true -- Set magic on, for regular expressions
opt.gdefault = true -- Apply global substitutions
opt.incsearch = true -- Makes search act like search in modern browsers
opt.grepprg = "rg --vimgrep"

-- }}}1
-- Completion {{{1

opt.infercase = true -- Ignore case on insert completion.

-- Better floating windows
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

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
  ".bundle", -- Ruby
  ".DS_Store", -- OSX
  "*.spl", -- compiled spelling word lists
  "*.sw?", -- Vim swap files
  "tags", -- ctags stuff
})

-- }}}2

opt.completeopt:remove({ "preview" }) -- Disable Scratch window

-- }}}1
-- Speed up! {{{1

opt.lazyredraw = true -- Do not redraw while running macros (much faster).
opt.synmaxcol = 800 -- vs 3000 by default.
opt.updatetime = 600 -- Smaller updatetime for CursorHold & CursorHoldI.
opt.fsync = false -- Let the OS decide when it's appropriate to flush the cache, rather than vim (much faster).

-- }}}1

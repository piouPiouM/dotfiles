local fp = require("moses")
local ui = require("ppm.ui")

local M = { themes = {}, providers = {} }

local function title(label)
  return string.format(" %s ", label)
end

local with_history = fp.curry(function(type, opts)
  return vim.tbl_deep_extend("force", {
    fzf_opts = {
      ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-" .. type
    }
  }, opts)
end)

local function without_history(opts)
  return vim.tbl_deep_extend("force", opts, {
    fzf_opts = {
      ["--history"] = false
    }
  })
end

local with_theme = fp.curry(function(name, opts)
  return vim.tbl_deep_extend("force", M.themes[name], opts)
end)

M.themes.cursor = {
  fzf_opts = {
    ["--info"] = "hidden",
    ["--layout"] = "reverse",
  },
  winopts_fn = function()
    local height = 15
    local position = vim.api.nvim_win_get_position(0)
    local border_size = 1
    local top_left = {
      col = vim.fn.wincol() + position[2],
      row = vim.fn.winline() + position[1] + border_size,
    }
    local winopts = {
      col = top_left.col,
      row = top_left.row + height < vim.o.lines
          and top_left.row
          or vim.fn.winline() + position[1] - height - border_size - 1,
      width = vim.o.columns - top_left.col - 4,
      height = height,
    }

    return winopts
  end
}

M.themes.vertical = {
  winopts = {
    preview = {
      layout = "vertical",
      vertical = "up",
    },
  },
}

M.themes.ivy = {
  fzf_opts = {
    ["--layout"] = "reverse",
    ["--no-separator"] = "",
    ["--pointer"] = "󰅂",
    ["--marker"] = " ",
  },
  winopts = {
    height = 0.42,
    width  = 1,
    row    = 1,
  },
}

M.themes.sidebar_right = {
  winopts_fn = function()
    local WIN_WIDTH = vim.o.columns
    local max_width = math.floor(WIN_WIDTH * 0.3)

    return {
      height  = 1,
      width   = max_width,
      col     = WIN_WIDTH - max_width - 1,
      row     = 0,
      preview = {
        hidden = "hidden",
        title = false,
      },
    }
  end
}

M.providers.complete_file = with_theme("cursor")({
  prompt = ui.icons.search .. " ",
  winopts = {
    title = title("Insert filepath"),
  },
})

M.providers.registers = M.themes.sidebar_right

M.providers.files = fp.pipe({
  git_icons = false,
  prompt = ui.icons.search .. " ",
  winopts = {
    title = title("Find Files"),
  },
}, with_history("files"), with_theme("ivy"))

M.providers.lines = fp.pipe({
  prompt = ui.icons.search .. " ",
  winopts = {
    title = title("Find Lines"),
  },
}, with_theme("vertical"))

M.providers.oldfiles = fp.pipe({
  prompt = ui.icons.search .. " ",
  winopts = {
    title = title("History"),
  },
}, with_history("files"), with_theme("ivy"))

M.providers.git = {
  files = fp.pipe({
    prompt = ui.icons.search .. " ",
    winopts = {
      title = title("Git files"),
    },
  }, with_history("files"), with_theme("ivy")),
  commits = fp.pipe({
    prompt = "  ",
    winopts = {
      title = title("Git commits"),
    },
  }, with_theme("vertical")),
  bcommits = fp.pipe({
    prompt = "  ",
    winopts = {
      title = title("Git commits of current buffer"),
    },
  }, with_theme("vertical")),
  icons = {
    ["M"] = { icon = ui.icons.diff_modified },
    ["D"] = { icon = ui.icons.diff_removed },
    ["A"] = { icon = ui.icons.diff_added },
    ["R"] = { icon = ui.icons.diff_renamed },
    -- ["C"] = { icon = "C"},
    -- ["T"] = { icon = "T"},
    -- ["?"] = { icon = "?"},
  },
}

M.providers.grep = fp.pipe({
  rg_glob = true,
}, with_history("grep"), with_theme("ivy"))

M.providers.keymaps = fp.pipe({
  prompt = ui.icons.search .. " ",
  no_action_zz = true,
  winopts = {
    title = title("Key Maps"),
  },
}, with_theme("ivy"))

local config = {
  "telescope",
  global_git_icons = true,
  global_resume = true,
  global_resume_query = true,
  file_icon_padding = vim.env.TERM == "xterm-kitty" and " " or "",
  winopts = {
    title = "",
    title_pos = "center",
  },
  previewers = {
    builtin = {
      extensions = {
        -- neovim terminal only supports `viu` block output
        ["gif"] = { "viu", "-t" },
        ["jpg"] = { "viu", "-t" },
        ["png"] = { "viu", "-t" },
      }
    }
  },
}

require('fzf-lua').setup(vim.tbl_deep_extend("force", config, M.providers))

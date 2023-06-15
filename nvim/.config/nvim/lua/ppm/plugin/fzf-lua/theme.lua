local M = { themes = {} }

M.with_theme = function(name)
  return function(opts)
    local theme = M.themes[name]
    local config = type(theme) == "function" and theme(opts) or theme
    return type(opts) == "table" and vim.tbl_deep_extend("force", config, opts) or config
  end
end

function M.themes.cursor(opts)
  return {
    fzf_opts = { ["--info"] = "hidden", ["--layout"] = "reverse" },
    winopts_fn = function()
      local position = vim.api.nvim_win_get_position(0)
      local border_size = 1
      local margin = 2
      local height = 15
      local cursor_col = vim.fn.wincol() + position[2]
      local cursor_row = vim.fn.winline() + position[1]
      local width = opts.content_width and opts.content_width + margin or math.floor(vim.o.columns * (1.5 / 3))
      local anchor_row = cursor_row + height < vim.o.lines and cursor_row + border_size or cursor_row - height -
          border_size - 1
      local anchor_col = cursor_col + width + margin > vim.o.columns and cursor_col - width or cursor_col

      return { col = anchor_col, row = anchor_row, height = height, width = width }
    end,
  }
end

--- ┌──────────────────────────────────────────────────┐
--- │                                                  │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Preview                │    │
--- │    │                 Preview                │    │
--- │    │                 Preview                │    │
--- │    └────────────────────────────────────────┘    │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Result                 │    │
--- │    │                 Result                 │    │
--- │    └────────────────────────────────────────┘    │
--- │    ┌────────────────────────────────────────┐    │
--- │    │                 Prompt                 │    │
--- │    └────────────────────────────────────────┘    │
--- │                                                  │
--- └──────────────────────────────────────────────────┘
M.themes.vertical = { winopts = { preview = { layout = "vertical", vertical = "up" } } }

M.themes.ivy = {
  fzf_opts = {
    ["--layout"] = "reverse",
    ["--no-separator"] = "",
    ["--pointer"] = "󰅂",
    ["--marker"] = " ",
  },
  winopts = { height = 0.42, width = 1, row = 1 },
}

M.themes.sidebar_right = {
  winopts_fn = function()
    local WIN_WIDTH = vim.o.columns
    local max_width = math.floor(WIN_WIDTH * 0.3)

    return {
      height = 1,
      width = max_width,
      col = WIN_WIDTH - max_width - 1,
      row = 0,
      preview = { hidden = "hidden", title = false },
    }
  end,
}

return M

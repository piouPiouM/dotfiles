local M = {}

--- Cursor layout dynamically positioned below the cursor if possible otherwise above.
--- Uses `content_width` option to precise the maximal width of the content to display.
--- This is usefull for adapting the window to the it's content.
---
--- ┌──────────────────────────────────────────────────┐
--- │                                                  │
--- │   █                                              │
--- │   ┌──────────────┐┌─────────────────────┐        │
--- │   │    Prompt    ││      Preview        │        │
--- │   ├──────────────┤│      Preview        │        │
--- │   │    Result    ││      Preview        │        │
--- │   │    Result    ││      Preview        │        │
--- │   └──────────────┘└─────────────────────┘        │
--- │                                         █        │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- └──────────────────────────────────────────────────┘
function M.cursor(opts)
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

--- ┌───────────────────────────────────────────────────┐
--- │                                                   │
--- │    ┌─────────────────────────────────────────┐    │
--- │    │                 Preview                 │    │
--- │    │                 Preview                 │    │
--- │    │                 Preview                 │    │
--- │    │                                         │    │
--- │    ├─────────────────────────────────────────┤    │
--- │    │                                         │    │
--- │    │                 Results                 │    │
--- │    │                 Results                 │    │
--- │    │                 Results                 │    │
--- │    ├─────────────────────────────────────────┤    │
--- │    │                 Prompt                  │    │
--- │    └─────────────────────────────────────────┘    │
--- │                                                   │
--- └───────────────────────────────────────────────────┘
M.vertical = {
  winopts = {
    preview = {
      border = "border-down",
      layout = "vertical",
    }
  },
}

--- ┌──────────────────────────────────────────────────┐
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │                                                  │
--- │ ┌──────────────────────┐┌──────────────────────┐ │
--- │ │        Prompt        ││                      │ │
--- │ │──────────────────────││       Preview        │ │
--- │ │       Results        ││       Preview        │ │
--- │ │       Results        ││       Preview        │ │
--- │ │       Results        ││       Preview        │ │
--- │ │                      ││                      │ │
--- │ └──────────────────────┘└──────────────────────┘ │
--- └──────────────────────────────────────────────────┘
M.ivy = {
  fzf_opts = {
    ["--layout"] = "reverse",
    ["--no-separator"] = "",
    ["--pointer"] = "󰅂",
    ["--marker"] = " ",
  },
  winopts = { height = 0.42, width = 1, row = 1 },
}

--- ┌──────────────────────────────────────────────────┐
--- │                                   ┌─────────────┐│
--- │                                   │   Preview   ││
--- │                                   │   Preview   ││
--- │                                   │   Preview   ││
--- │                                   │             ││
--- │                                   │─────────────││
--- │                                   │             ││
--- │                                   │             ││
--- │                                   │   Results   ││
--- │                                   │   Results   ││
--- │                                   │   Results   ││
--- │                                   │─────────────││
--- │                                   │   Prompt    ││
--- │                                   └─────────────┘│
--- └──────────────────────────────────────────────────┘
M.sidebar_right = {
  winopts = {
    border = "single",
    preview = {
      border = "border-down",
      layout = "vertical",
      wrap = "wrap",
    }
  },
  winopts_fn = function()
    local WIN_WIDTH = vim.o.columns
    local max_width = math.floor(WIN_WIDTH * 0.25)

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

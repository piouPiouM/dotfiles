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
return function(opts)
  return {
    winopts = function()
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

      return vim.tbl_deep_extend("force",
        opts.winopts or {},
        {
          col = anchor_col,
          row = anchor_row,
          height = height,
          width = width
        })
    end
  }
end

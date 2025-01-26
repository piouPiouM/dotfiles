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
return function(opts)
  return {
    winopts = function()
      local WIN_WIDTH = vim.o.columns
      local max_width = math.floor(WIN_WIDTH * 0.25)

      return vim.tbl_deep_extend("force",
        opts.winopts or {},
        {
          border = "single",
          height = 1,
          width = max_width,
          col = WIN_WIDTH - max_width - 1,
          row = 0,
          preview = {
            border = "border-down",
            hidden = "hidden",
            layout = "vertical",
            title = false,
            wrap = "wrap",
          },
        })
    end,
  }
end
local fp = require("ppm.toolkit.fp")

---@param opts NoiceConfig
local with_presets = function(opts)
  return vim.tbl_deep_extend("force", opts or {}, {
    presets = {
      command_palette = false,
    },
  })
end

---@param opts NoiceConfig
local with_classic_cmd = function(opts)
  return vim.tbl_deep_extend("force", opts or {}, {
    cmdline = {
      view = "cmdline",
    },
  })
end

---@param opts NoiceConfig
local filter_noise = function(opts)
  return vim.tbl_deep_extend("force", opts or {}, {
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        view = "mini",
        filter = {
          event = "msg_showmode",
          any = {
            { find = "recording" },
          },
        },
      },
    },
  })
end

local override_lsp = function(opts)
  return vim.tbl_deep_extend("force", opts or {}, {
    lsp = {
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = false,
      },
    },
  })
end

local pimp = function(opts)
  return vim.tbl_deep_extend("force", opts or {}, {
    timeout = 2500,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    -- on_open = function(win)
    --   vim.api.nvim_win_set_config(win, { zindex = 100 })
    -- end,
  })
end

---@param opts NoiceConfig
return function(_, opts)
  return fp.pipe(
    opts,
    pimp,
    with_presets,
    with_classic_cmd,
    override_lsp,
    filter_noise
  )
end

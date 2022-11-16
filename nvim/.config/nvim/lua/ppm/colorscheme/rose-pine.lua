local M = {}

M.setup = function()
  local p = require("rose-pine.palette")
  local background = p.base

  require("rose-pine").setup({
    dark_variant = "moon",
    dim_nc_background = true,
    highlight_groups = {
      NavicIconsFile = { fg = p.pine, bg = background },
      NavicIconsModule = { fg = p.pine, bg = background },
      NavicIconsNamespace = { fg = p.pine, bg = background },
      NavicIconsPackage = { fg = p.pine, bg = background },
      NavicIconsClass = { fg = p.gold, bg = background },
      NavicIconsMethod = { fg = p.pine, bg = background },
      NavicIconsProperty = { fg = p.gold, bg = background },
      NavicIconsField = { fg = p.gold, bg = background },
      NavicIconsConstructor = { fg = p.pine, bg = background },
      NavicIconsEnum = { fg = p.gold, bg = background },
      NavicIconsInterface = { fg = p.gold, bg = background },
      NavicIconsFunction = { fg = p.pine, bg = background },
      NavicIconsVariable = { fg = p.foam, bg = background },
      NavicIconsConstant = { fg = p.rose, bg = background },
      NavicIconsString = { fg = p.gold, bg = background },
      NavicIconsNumber = { fg = p.gold, bg = background },
      NavicIconsBoolean = { fg = p.rose, bg = background },
      NavicIconsArray = { fg = p.rose, bg = background },
      NavicIconsObject = { fg = p.rose, bg = background },
      NavicIconsKey = { fg = p.pink, bg = background },
      NavicIconsNull = { fg = p.rose, bg = background },
      NavicIconsEnumMember = { fg = p.love, bg = background },
      NavicIconsStruct = { fg = p.pine, bg = background },
      NavicIconsEvent = { fg = p.pine, bg = background },
      NavicIconsOperator = { fg = p.foam, bg = background },
      NavicIconsTypeParameter = { fg = p.pine, bg = background },
      NavicText = { fg = p.text, bg = background },
      NavicSeparator = { fg = p.text, bg = background },
    },
  })
end

M.use = function() vim.cmd [[colorscheme rose-pine]] end

return M

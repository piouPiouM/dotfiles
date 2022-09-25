local augend = require("dial.augend")

local edges = augend.constant.new({
  elements = { "top", "right", "bottom", "left" },
  word = true,
  cyclic = true,
})

local boundaries = augend.constant.new(
  { elements = { "first", "last" }, word = true, cyclic = true })

local onOff = augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true })
local yesNo = augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true })

local common = {
  augend.constant.alias.Alpha,
  augend.constant.alias.alpha,
  augend.constant.alias.bool,
  augend.date.alias["%m/%d/%Y"],
  augend.integer.alias.decimal_int,
  augend.integer.alias.hex,
  augend.semver.alias.semver,
  boundaries,
  onOff,
  yesNo,
}

require("dial.config").augends:register_group({
  default = common,
  front = vim.tbl_extend("force", common, { edges }),
  case = {
    augend.case.new({
      types = { "camelCase", "snake_case", "kebab-case", "PascalCase", "SCREAMING_SNAKE_CASE" },
      cyclic = true,
    }),
  },
})

local pipe = require("ppm.toolkit.fp").pipe
local with_theme = require("ppm.plugin.fzf-lua.decorators").with_theme
local extend = require("ppm.plugin.fzf-lua.decorators").extend

return pipe(
  {},
  with_theme("ivy"),
  with_theme("up"),
  extend({
    previewer = { toggle_behavior = "extend" },
    winopts = { title_pos = "center" }
  })
)
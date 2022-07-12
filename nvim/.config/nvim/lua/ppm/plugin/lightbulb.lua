local ui = require("ppm.ui")

require("nvim-lightbulb").setup({
  autocmd = { enabled = false },
  sign = { enabled = true, text = ui.icons.bulb, priority = 15 },
  virtual_text = { enabled = false },
})

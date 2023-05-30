local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'catppuccin-mocha'
-- config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14

return config

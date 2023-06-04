# -----------------------------------------------------------------------------
# Target: Themes for Linux applications
# -----------------------------------------------------------------------------

THEME_CATPPUCCIN_ROFI := $(XDG_DATA_HOME)/rofi/themes/catppuccin-frappe.rasi \
												$(XDG_DATA_HOME)/rofi/themes/catppuccin-latte.rasi \
												$(XDG_DATA_HOME)/rofi/themes/catppuccin-macchiato.rasi \
												$(XDG_DATA_HOME)/rofi/themes/catppuccin-mocha.rasi

THEME_ROSE_PINE_ROFI := $(XDG_DATA_HOME)/rofi/themes/rose-pine.rasi \
												$(XDG_DATA_HOME)/rofi/themes/rose-pine-dawn.rasi \
												$(XDG_DATA_HOME)/rofi/themes/rose-pine-moon.rasi

theme-catppuccin:: | $(THEME_CATPPUCCIN_ROFI)
.PHONY: theme-catppuccin

theme-rose-pine:: | $(THEME_ROSE_PINE_ROFI)
.PHONY: theme-rose-pine

$(THEME_CATPPUCCIN_ROFI):
	@echo "$(PURPLE)• Download $(@F) theme for Rofi$(RESET)"
	@curl --silent --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/catppuccin/rofi/main/basic/.local/share/rofi/themes/$(@F)"

$(THEME_ROSE_PINE_ROFI):
	@echo "$(PURPLE)• Download $(@F) theme for Rofi$(RESET)"
	@curl --silent --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/rose-pine/rofi/main/$(@F)"

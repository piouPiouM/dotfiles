# -----------------------------------------------------------------------------
# Target: Themes
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
# -----------------------------------------------------------------------------

NIGHTFOX_THEME_PATH := "$(XDG_DATA_HOME)/nvim/site/pack/packer/start/nightfox.nvim/extra"

THEME_CATPPUCCIN_BAT := $(XDG_CONFIG_HOME)/bat/themes/catppuccin-frappe.tmTheme \
												$(XDG_CONFIG_HOME)/bat/themes/catppuccin-latte.tmTheme \
												$(XDG_CONFIG_HOME)/bat/themes/catppuccin-macchiato.tmTheme \
												$(XDG_CONFIG_HOME)/bat/themes/catppuccin-mocha.tmTheme

THEME_CATPPUCCIN_BTOP := $(XDG_CONFIG_HOME)/btop/themes/catppuccin-frappe.theme \
												 $(XDG_CONFIG_HOME)/btop/themes/catppuccin-latte.theme \
												 $(XDG_CONFIG_HOME)/btop/themes/catppuccin-macchiato.theme \
												 $(XDG_CONFIG_HOME)/btop/themes/catppuccin-mocha.theme

THEME_CATPPUCCIN_LAZYGIT := $(XDG_DATA_HOME)/lazygit/themes/catppuccin-frappe.yml \
														$(XDG_DATA_HOME)/lazygit/themes/catppuccin-latte.yml \
														$(XDG_DATA_HOME)/lazygit/themes/catppuccin-macchiato.yml \
														$(XDG_DATA_HOME)/lazygit/themes/catppuccin-mocha.yml

THEME_ROSE_PINE_FZF := $(XDG_DATA_HOME)/fzf/themes/rose-pine.sh \
											 $(XDG_DATA_HOME)/fzf/themes/rose-pine-dawn.sh \
											 $(XDG_DATA_HOME)/fzf/themes/rose-pine-moon.sh

## Install themes for various tools.
install-themes:: theme-catppuccin theme-nightfox theme-rose-pine
.PHONY: install-themes

$(THEME_CATPPUCCIN_BAT):
	@echo "$(PURPLE)• Download $(@F) for bat$(RESET)"
	@curl --silent --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/bat/main/$(subst catppuccin,Catppuccin,$(@F))" -o $(@F)

$(THEME_CATPPUCCIN_BTOP):
	@echo "$(PURPLE)• Download $(@F) for btop$(RESET)"
	@curl --silent --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/btop/main/themes/$(subst -,_,$(@F))" -o $(@F)

$(THEME_CATPPUCCIN_LAZYGIT):
	@echo "$(PURPLE)• Download $(@F) for Lazygit$(RESET)"
	@curl --silent --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/lazygit/main/themes/$(subst catppuccin-,,$(@F))" -o $(@F)
	@$(GNU_SED) -i 's/^/  /;1s/^/gui:\n/' "$@"

$(THEME_ROSE_PINE_FZF):
	@echo "$(PURPLE)• Download $(@F) for fzf$(RESET)"
	@curl --silent --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/rose-pine/fzf/main/dist/$(@F)"
	@$(GNU_SED) -i 's/FZF_DEFAULT_OPTS/FZF_THEME/' $(@)

## Download Catppuccin theme.
theme-catppuccin:: | $(THEME_CATPPUCCIN_BAT) $(THEME_CATPPUCCIN_BTOP) $(THEME_CATPPUCCIN_LAZYGIT)
	@$(MAKE) --silent theme-postinstall
.PHONY: theme-catppuccin

## Download Nightfox theme.
theme-nightfox:
	@echo "$(PURPLE)• Install Nightfox for Kitty from Neovim$(RESET)"
	@cp "$(NIGHTFOX_THEME_PATH)/dawnfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Dawnfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/dayfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Dayfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/duskfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Duskfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/nightfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Nightfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/nordfox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Nordfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/terafox/nightfox_kitty.conf" "./kitty/.config/kitty/themes/Terafox.conf"
.PHONY: theme-nightfox

## Download Rosé Pine theme.
theme-rose-pine:: | $(THEME_ROSE_PINE_FZF)
	@$(MAKE) --silent theme-postinstall
.PHONY: theme-rose-pine

theme-postinstall:
	@$(call cmd_exists,bat) && bat cache --build > /dev/null
.PHONY: theme-postinstall

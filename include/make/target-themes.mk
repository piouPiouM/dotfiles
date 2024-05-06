# -----------------------------------------------------------------------------
# Target: Themes
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
# -----------------------------------------------------------------------------

KITTY_PATH := $(XDG_CONFIG_HOME)/kitty/themes
FZF_PATH := $(XDG_DATA_HOME)/fzf/themes

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

THEME_ROSE_PINE_BTOP := $(XDG_CONFIG_HOME)/btop/themes/rose-pine.theme \
												 $(XDG_CONFIG_HOME)/btop/themes/rose-pine-dawn.theme \
												 $(XDG_CONFIG_HOME)/btop/themes/rose-pine-moon.theme

THEME_ROSE_PINE_FZF := $(FZF_PATH)/rose-pine.sh \
											 $(FZF_PATH)/rose-pine-dawn.sh \
											 $(FZF_PATH)/rose-pine-moon.sh

## Install themes for various tools.
install-themes:: \
	theme-catppuccin \
	theme-nightfox \
	theme-github \
	theme-rose-pine
.PHONY: install-themes

$(THEME_CATPPUCCIN_BAT): FORCE
	$(eval REMOTE_NAME := $(shell echo "$(@F)" | $(GNU_SED) -e "s/\b\(.\)/\u\1/g; s/\.T/\.t/; s/-/%20/"))
	@curl $(CURL_FLAGS) --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/bat/main/themes/$(REMOTE_NAME)" -o $(@F) && $(call success,$(@F) for bat) || $(call failure,$(@F) for bat)

$(THEME_CATPPUCCIN_BTOP): FORCE
	# https://github.com/catppuccin/btop/releases/latest/download/themes.tar.gz
	@curl $(CURL_FLAGS) --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/btop/main/themes/$(subst -,_,$(@F))" -o $(@F) && $(call success,$(@F) for btop) || $(call failure,$(@F) for btop)

$(THEME_CATPPUCCIN_LAZYGIT): FORCE
	@curl $(CURL_FLAGS) --output-dir $(@D) "https://raw.githubusercontent.com/catppuccin/lazygit/main/themes/$(subst catppuccin-,,$(@F))" -o $(@F) && $(call success,$(@F) for Lazygit) || $(call failure,$(@F) for Lazygit)
	@$(GNU_SED) -i 's/^/  /;1 i gui:' "$@"

$(THEME_ROSE_PINE_BTOP): FORCE
	@curl $(CURL_FLAGS) --output-dir $(@D) "https://raw.githubusercontent.com/rose-pine/btop/main/$(@F)" -o $(@F) && $(call success,$(@F) for btop) || $(call failure,$(@F) for btop)
$(THEME_ROSE_PINE_FZF): FORCE
	@curl $(CURL_FLAGS) --output-dir $(@D) --remote-name "https://raw.githubusercontent.com/rose-pine/fzf/main/dist/$(@F)" && $(call success,$(@F) for fzf) || $(call failure,$(@F) for fzf)
	@$(GNU_SED) -i 's/FZF_DEFAULT_OPTS/FZF_THEME/' $(@)

## Download Catppuccin theme.
theme-catppuccin::
	@echo "$(PURPLE)• Install Catppuccin themes$(RESET)"
	@$(MAKE) --silent $(THEME_CATPPUCCIN_BAT)
	@$(MAKE) --silent $(THEME_CATPPUCCIN_BTOP)
	@$(MAKE) --silent $(THEME_CATPPUCCIN_LAZYGIT)
	@$(MAKE) --silent theme-postinstall
.PHONY: theme-catppuccin

## Download Github Contrib themes.
theme-github: TMP := $(shell mktemp -d)
theme-github::
	@echo "$(PURPLE)• Install Github themes$(RESET)"
	@git clone --quiet --depth=1 https://github.com/projekt0n/github-theme-contrib.git $(TMP)
	@cp -f $(TMP)/themes/kitty/*.conf $(KITTY_PATH)/ && $(call success,Kitty)
	@cp -f $(TMP)/themes/fzf/github* $(FZF_PATH)/ && $(call success,fzf)
	@rm -rf $(TMP)
	@$(MAKE) --silent $(addsuffix .sh,$(wildcard $(FZF_PATH)/github_*))
.PHONY: theme-github

$(FZF_PATH)/github_%.sh: $(FZF_PATH)/github_%
	@$(GNU_SED) -i -E "s/.*'(.*)'/export FZF_THEME=\"\1\"/;s@ --@\n  --@g" $<
	@mv $< $(subst _,-,$@)
	@$(call success,Format fzf's theme $(subst _,-,$(@F)))

## Download Nightfox theme.
theme-nightfox: NIGHTFOX_THEME_PATH := "$(XDG_DATA_HOME)/nvim/lazy/nightfox.nvim/extra"
theme-nightfox:
	@echo "$(PURPLE)• Install Nightfox for Kitty from Neovim$(RESET)"
	@cp "$(NIGHTFOX_THEME_PATH)/carbonfox/kitty.conf" "$(KITTY_PATH)/Carbonfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/dawnfox/kitty.conf" "$(KITTY_PATH)/Dawnfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/dayfox/kitty.conf" "$(KITTY_PATH)/Dayfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/duskfox/kitty.conf" "$(KITTY_PATH)/Duskfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/nightfox/kitty.conf" "$(KITTY_PATH)/Nightfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/nordfox/kitty.conf" "$(KITTY_PATH)/Nordfox.conf"
	@cp "$(NIGHTFOX_THEME_PATH)/terafox/kitty.conf" "$(KITTY_PATH)/Terafox.conf"
.PHONY: theme-nightfox

## Download Rosé Pine theme.
theme-rose-pine::
	@echo "$(PURPLE)• Install Rose Pine themes$(RESET)"
	@$(MAKE) --silent $(THEME_ROSE_PINE_BTOP)
	@$(MAKE) --silent $(THEME_ROSE_PINE_FZF)
	@$(MAKE) --silent theme-postinstall
.PHONY: theme-rose-pine

theme-postinstall:
	@echo "$(PURPLE)• Build bat themes$(RESET)"
	@$(call cmd_exists,bat) && bat cache --build > /dev/null
.PHONY: theme-postinstall
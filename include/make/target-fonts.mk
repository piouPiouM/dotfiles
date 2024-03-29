# -----------------------------------------------------------------------------
# Target: Fonts
# -----------------------------------------------------------------------------

FONTS_DIR = $(XDG_DATA_HOME)/fonts
FONTS_IA = $(FONTS_DIR)/iAWriterQuattroS-Bold.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-BoldItalic.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-Italic.ttf \
					 $(FONTS_DIR)/iAWriterQuattroS-Regular.ttf

## Download and install fonts.
install-fonts:: \
	install-fonts-codicon \
	install-fonts-nerd \
	install-fonts-ibm-plex \
	$(FONTS_IA) | $(ENSURE_DIRS)
	@$(MAKE) postinstall-fonts
.PHONY: install-fonts 

## Download and install iA Writter QuattroS font.
$(FONTS_IA):
	@echo "$(PURPLE)• Download $(@F) font$(RESET)"
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Quattro/Static/$(@F)"

## Download and install Codicon font.
install-fonts-codicon:
	@echo "$(PURPLE)• Download Codicon font$(RESET)"
	@curl -fsSL --create-dirs --output-dir $(FONTS_DIR) --remote-name "https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf"
.PHONY: install-fonts-codeicon

## Download and install IBM Plex.
install-fonts-ibm-plex:
	@echo "$(PURPLE)• Download IMB Plex fonts$(RESET)"
	$(eval TMP := $(shell mktemp -d))
	@curl -fsSL --output-dir $(TMP) --remote-name "https://github.com/IBM/plex/releases/latest/download/OpenType.zip"
	@unzip -qq $(TMP)/OpenType.zip -d $(TMP)
	@cp $(TMP)/OpenType/IBM-Plex-{Mono,Sans{,-Condensed},Serif}/*.otf $(FONTS_DIR)/
	@cp $(TMP)/OpenType/IBM-Plex-Sans-JP/hinted/*.otf $(FONTS_DIR)/
	@rm -rf $(TMP)
.PHONY: install-fonts-ibm-plex

## Download and install Nerd Fonts Symbols only.
install-fonts-nerd-symbols-only: KITTY_NERD_FONTS_CONF := kitty/.config/kitty/nerd-fonts.conf
install-fonts-nerd-symbols-only: TMP := $(shell mktemp -d)
install-fonts-nerd-symbols-only: VERSION := $(shell curl -fsSL https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | $(GNU_GREP) -oP '(?<=tag_name": ")(v[^"]+)')
install-fonts-nerd-symbols-only:
	@echo "$(PURPLE)• Download Nerd Fonts$(RESET)"
	@curl -fsSL --output-dir $(TMP) --remote-name "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip"
	@unzip -qq $(TMP)/NerdFontsSymbolsOnly.zip *.ttf -d $(TMP)
	@mv $(TMP)/*.ttf $(FONTS_DIR)/
	@rm -rf $(TMP)
	@$(MAKE) postinstall-fonts
	@echo "$(PURPLE)• Updating Kitty's configuration to handle Nerd fonts' symbols$(RESET)"
	@bin/kitty-config-nerd-font $(realpath $(KITTY_NERD_FONTS_CONF)) $(VERSION)
	@echo "$(PURPLE)• Generate JSON file used by fzf-lua$(RESET)"
	@bin/nerdfonts-fetch-glyphnames $(VERSION) "$(XDG_DATA_HOME)/$$USER/symbols/nerdfonts.json"
.PHONY: install-fonts-nerd-symbols-only

## Download and install Nerd Fonts.
install-fonts-nerd: install-fonts-nerd-symbols-only
	@echo "$(PURPLE)• Download JetBrains Mono Nerd Font$(RESET)"
	$(eval TMP := $(shell mktemp -d))
	@curl -fsSL --output-dir $(TMP) --remote-name "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
	@unzip -qq $(TMP)/JetBrainsMono.zip *.ttf -d $(TMP)
	@mv $(TMP)/*.ttf $(FONTS_DIR)/
	@rm -rf $(TMP)
.PHONY: install-fonts-nerd
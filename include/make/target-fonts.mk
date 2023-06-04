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
	@$(MAKE) --silent postinstall-fonts
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

## Download and install Nerd Fonts.
install-fonts-nerd:
	@echo "$(PURPLE)• Download Nerd Fonts$(RESET)"
	$(eval TMP := $(shell mktemp -d))
	@curl -fsSL --output-dir $(TMP) --remote-name "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip"
	@unzip -qq $(TMP)/NerdFontsSymbolsOnly.zip *.ttf -d $(TMP)
	@curl -fsSL --output-dir $(TMP) --remote-name "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
	@unzip -qq $(TMP)/JetBrainsMono.zip *.ttf -d $(TMP)
	@mv $(TMP)/*.ttf $(FONTS_DIR)/
	@rm -rf $(TMP)
.PHONY: install-fonts-nerd

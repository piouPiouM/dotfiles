# -----------------------------------------------------------------------------
# Target: Fonts for Linux
# -----------------------------------------------------------------------------

install-fonts::
	@echo "$(PURPLE)• Installing packaged fonts$(RESET)"
	@sudo dnf group install fonts
	@$(INSTALL) \
		adobe-source-code-pro-fonts \
		adobe-source-sans-pro-fonts \
		adobe-source-serif-pro-fonts \
		bitstream-vera-sans-fonts \
		bitstream-vera-serif-fonts \
		dejavu-sans-fonts \
		dejavu-serif-fonts \
		jetbrains-mono-fonts \
		google-carlito-fonts \
		google-noto-emoji-fonts \
		google-roboto-fonts
.PHONY: install-fonts

postinstall-fonts:
	@echo "$(PURPLE)• Installing new downloaded fonts$(RESET)"
	@fc-cache -fr $(FONTS_DIR)
.PHONY: postinstall-fonts

# -----------------------------------------------------------------------------
# Target: Fonts for macOS
# -----------------------------------------------------------------------------

postinstall-fonts:
	@echo "$(PURPLE)• Installing new fonts$(RESET)"
	@cp $(FONTS_DIR)/*.ttf ~/Library/Fonts/
.PHONY: postinstall-fonts

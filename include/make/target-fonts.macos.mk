# -----------------------------------------------------------------------------
# Target: Fonts for macOS
# -----------------------------------------------------------------------------

postinstall-fonts:
	@echo "$(PURPLE)• Installing new fonts$(RESET)"
	@cp $(FONTS_DIR)/*.{otf,ttf} ~/Library/Fonts/
.PHONY: postinstall-fonts
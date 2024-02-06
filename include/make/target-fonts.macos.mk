# -----------------------------------------------------------------------------
# Target: Fonts for macOS
# -----------------------------------------------------------------------------

postinstall-fonts:
	@echo "$(PURPLE)• Installing new fonts$(RESET)"
	@cp $(FONTS_DIR)/*.otf ~/Library/Fonts/ 2>/dev/null || :
	@cp $(FONTS_DIR)/*.ttf ~/Library/Fonts/ 2>/dev/null || :
.PHONY: postinstall-fonts
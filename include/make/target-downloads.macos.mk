# -----------------------------------------------------------------------------
# Target: Downloads for macOS
# -----------------------------------------------------------------------------

bin/imgcat:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/$(@F)"
	@chmod +x $@

bin/imgls:
	@curl --silent --create-dirs -o $@ "https://iterm2.com/utilities/$(@F)"
	@chmod +x $@

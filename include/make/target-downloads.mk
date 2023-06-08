# -----------------------------------------------------------------------------
# Target: Downloads
# -----------------------------------------------------------------------------

bin/vim-profiler:
	@curl --silent --create-dirs -o $@ "https://raw.githubusercontent.com/bchretien/vim-profiler/master/vim-profiler.py"
	@chmod +x $@

ranger/.config/ranger/devicons.py ranger/.config/ranger/plugins/devicons_linemode.py:
	@curl --silent -o $@ "https://raw.githubusercontent.com/alexanderjeurissen/ranger_devicons/master/$(notdir $@)"

${XDG_CACHE_HOME}/zim/zimfw.zsh:
	@curl -fsSL --create-dirs -o $@ "https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh"

$(XDG_DATA_HOME)/dictionaries/fr.wordlist: $(ENSURE_DIRS)
	@echo -n "$(PURPLE)• Download French wordlist…$(RESET)"
	@curl --silent --create-dirs --output-dir $(XDG_DATA_HOME)/dictionaries/ --output "fr.wordlist" "https://raw.githubusercontent.com/redacted/XKCD-password-generator/master/xkcdpass/static/fr-corrected.txt" && $(GNU_SED) -i 's@c/@ç@g' "$(XDG_DATA_HOME)/dictionaries/fr.wordlist" && echo ' $(GREEN)$(RESET)' || echo ' $(RED)✗$(RESET)'

download-dictionaries: $(XDG_DATA_HOME)/dictionaries/fr.wordlist
.PHONY: download-dictionaries

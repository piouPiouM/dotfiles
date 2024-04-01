SPECIFIC_TO_LINK =

BREWFILE := $(realpath setup/macos/Brewfile)

# I use GNU sed and GNU grep for the sake of consistency.
# For example, the macOS version of the tool performs "in-place" replacement using the `-i ''` option, not `-i` as in
# the GNU version.
GNU_SED := gsed
GNU_GREP := ggrep

INSTALL := brew install

COMPAT_PACKAGES := coreutils curl gnu-sed grep
REQUIRED_PACKAGES := bash zsh kitty pcre2 wget go rust stow
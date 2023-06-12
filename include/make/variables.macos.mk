SPECIFIC_TO_LINK =

BREWFILE := $(realpath setup/macos/Brewfile)

# I use GNU sed for the sake of consistency.
# For example, the macOS version of the tool performs "in-place" replacement using the `-i ''` option, not `-i` as in
# the GNU version.
GNU_SED := gsed

INSTALL := brew install
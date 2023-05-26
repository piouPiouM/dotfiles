#!/usr/bin/env zsh

# Properly setting $PATH for zsh on macOS and Linux by declaring the path
# in `.zprofile` instead of `.zshenv`.
# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2

#
# Path management
#

path=(
  "$XDG_DATA_HOME/bin/$CURRENT_OS"
  "$XDG_DATA_HOME"/bin
  "$GOBIN"
  "$PNPM_HOME"
  "$HOME"/.luarocks/bin
  "$CARGO_HOME"/bin
	"$XDG_DATA_HOME"/gem/ruby/3.1.0/bin
	"$HOME"/.gem/ruby/2.6.0/bin
	"${=path}"
)

# Eliminate duplicates in *paths
typeset -gU cdpath fpath mailpath path

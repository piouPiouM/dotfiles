#!/usr/bin/env zsh

# Properly setting $PATH for zsh on macOS and Linux by declaring the path
# in `.zprofile` instead of `.zshenv`.
# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2

source "$ZDOTDIR"/include/detect-os.zsh

#
# Path management
#

_GEM_HOME="$(gem environment user_gemhome 2>/dev/null)"
_GEM_BIN=${_GEM_HOME:+"${_GEM_HOME}"/bin}

local _current_path="${=path}"

path=(
  "$XDG_DATA_HOME/bin/$CURRENT_OS"
  "$XDG_DATA_HOME"/bin
  "$HOME"/.local/bin
  "$HOME"/bin
  "$GOBIN"
  "$N_PREFIX"/bin
  "$PNPM_HOME"
)

if [[ -s "$ZDOTDIR/plugins/$CURRENT_OS/path.zsh" ]] then
  typeset -gU path
  source "$ZDOTDIR/plugins/$CURRENT_OS/path.zsh"
fi

path+=(
  "$NPM_PACKAGES"/bin
  "$HOME"/.luarocks/bin
  "$CARGO_HOME"/bin
	"$_GEM_BIN"
	"${=_current_path}"
)

fpath=(
  "$XDG_DATA_HOME"/bin/functions
	"${=fpath}"
)

# Remove empty values
path=($path)
fpath=($fpath)

# Eliminate duplicates in *paths
typeset -gU cdpath fpath mailpath path
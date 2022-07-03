#!/usr/bin/env zsh

# Startup files
# https://zsh.sourceforge.io/Intro/intro_3.html
#
# $ZDOTDIR/.zshenv
# $ZDOTDIR/.zprofile
# $ZDOTDIR/.zshrc
# $ZDOTDIR/.zlogin
# $ZDOTDIR/.zlogout
#
# `.zshenv' is sourced on all invocations of the shell, unless the -f option is set. It should contain commands to set
# the command search path, plus other important environment variables. `.zshenv' should not contain commands that produce
# output or assume the shell is attached to a tty.

skip_global_compinit=1

# setopt noglobalrcs

local UNAME_S=$(uname -s 2>/dev/null || echo "unkown")
if [[ "${UNAME_S:l}" == "darwin" ]]
then
  export CURRENT_OS="macos"
  export OS_MACOS=true
elif [[ "${UNAME_S:l}" == "linux" ]]
then
  export CURRENT_OS="linux"
  export OS_LINUX=true
else
  export CURRENT_OS="unknown"
fi

#
# XDG Specification
#

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Clean-up my home directory
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export ZIM_HOME="$XDG_CACHE_HOME/zim"
export ZSH_EVALCACHE_DIR="$XDG_CACHE_HOME/zsh/.evalcache"
export FZF_PATH="$XDG_CONFIG_HOME/fzf"
export FZF_PREVIEW_ADVANCED=true
export TEALDEER_CONFIG_DIR="$XDG_CONFIG_HOME/tealdeer"
export TEALDEER_CACHE_DIR="$XDG_CACHE_HOME/tealdeer"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/rc"

export PPM_BREW_PREFIX=/usr/local
export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

# Opting out
export HOMEBREW_NO_ANALYTICS=1

#
# Language
#

if [[ -z "$LANG" ]]; then
	export LANG='fr_FR.UTF-8'
	export LANGUAGE=fr_FR.UTF-8
fi

export LC_COLLATE=fr_FR.UTF-8
export LC_CTYPE=fr_FR.UTF-8
export LC_MESSAGES=fr_FR.UTF-8
export LC_MONETARY=fr_FR.UTF-8
export LC_NUMERIC=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
export LESSCHARSET=utf-8

#
# Development languages
#

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

#
# Path management
#

# export LOCAL_BIN_CURRENT_OS=[[ $OSTYPE == "darwin*" ]] && "$XDG_DATA_HOME/bin/macos" || "$XDG_DATA_HOME/bin/linux"

path=(
  $GOBIN
  # $GOROOT/bin
  $HOME/.luarocks/bin
  $HOME/.cargo/bin
	$XDG_DATA_HOME/gem/ruby/bin
	$XDG_DATA_HOME/bin
	"$XDG_DATA_HOME/bin/${CURRENT_OS}"
	"$HOME/.gem/ruby/2.6.0/bin"
	$HOME/bin
	$path
)

# Eliminates duplicates in *paths
typeset -gU cdpath fpath mailpath path

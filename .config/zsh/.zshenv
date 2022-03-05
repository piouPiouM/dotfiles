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

export PPM_BREW_PREFIX=/usr/local
export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

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
# Path management
#

# Eliminates duplicates in *paths
typeset -gU cdpath fpath path

path=(
	$PPM_BREW_PREFIX/{bin,sbin}
	$path
)

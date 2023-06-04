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
# `.zshenv' is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search path, plus other important environment variables.
# `.zshenv' should not contain commands that produce output or assume the shell is attached to a tty.

skip_global_compinit=1

# setopt noglobalrcs

#
# XDG Specification
#
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME"/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME"/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME"/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME"/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-"$TMPDIR"}
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"


# Clean-up my home directory
source "$ZDOTDIR"/include/detect-os.zsh
export HISTFILE="$XDG_CACHE_HOME"/zsh/history
export _ZO_DATA_DIR="$XDG_DATA_HOME"/zoxide
export ZIM_HOME="$XDG_CACHE_HOME"/zim
export ZSH_EVALCACHE_DIR="$XDG_CACHE_HOME"/zsh/.evalcache
export FZF_PATH="$XDG_CONFIG_HOME"/fzf
export TEALDEER_CONFIG_DIR="$XDG_CONFIG_HOME"/tealdeer
export TEALDEER_CACHE_DIR="$XDG_CACHE_HOME"/tealdeer
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/rc
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export CARGO_HOME="$XDG_DATA_HOME"/cargo

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
# Development languages
#

export GOPATH="$HOME"/go
export GOBIN="$GOPATH"/bin
export NPM_PACKAGES="$XDG_DATA_HOME"/npm-packages
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PNPM_HOME="$XDG_DATA_HOME"/pnpm

#
# Local to current device
#

if [[ -s "$XDG_DATA_HOME"/zsh/exports.zsh ]] then
  source "$XDG_DATA_HOME"/zsh/exports.zsh
fi

#
# Force loading of .zprofile in charge of updating $PATH.
#
if [[ ! -o login ]]; then
  source "$ZDOTDIR"/.zprofile
fi

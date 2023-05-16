#!/usr/bin/env zsh

unsetopt PROMPT_SP

# XDG Specification
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:=$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=$HOME/.cache}

PPM_BREW_PREFIX=/usr/local

# Path
PATH=/usr/local/bin:/usr/local/sbin:$PATH

if which ruby >/dev/null && which gem >/dev/null; then
	PATH="$($PPM_BREW_PREFIX/opt/ruby/bin/ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
	PATH="$PPM_BREW_PREFIX/opt/ruby/bin:$PATH"
fi

[ -d "$PPM_BREW_PREFIX/opt/python@2/bin" ] && PATH="$PPM_BREW_PREFIX/opt/python@2/bin:$PATH"

export PATH="$XDG_DATA_HOME/bin:$HOME/bin:$PATH"
export NODE_PATH="$PPM_BREW_PREFIX/lib/node_modules"
export PPM_BREW_PREFIX

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# export LESS='-iFR'
export PAGER='less'

export SVN_EDITOR=$EDITOR

export LC_CTYPE=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8

# -------------------------------------------------------------------
# fzf
# -------------------------------------------------------------------

FZF_PREWIEW_OPTS='(bat {} || highlight -O ansi -f --replace-tabs=2 {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'

FZF_DEFAULT_OPTS='--multi --inline-info --cycle --tabstop=2 --color gutter:-1'

# Iceberg theme
FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color fg:#c6c8d1,bg:#161821,hl:#e2a478,fg+:#cdd1e6,bg+:#2a3158,hl+:#e27878
  --color info:#a093c7,prompt:#818596,spinner:#b4be82
  --color pointer:#e27878,marker:#89b8c2,header:#6b7089
'
export FZF_DEFAULT_OPTS
export FZF_CTRL_T_OPTS="--preview '${FZF_PREWIEW_OPTS}' --height 70%"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

if which rg >/dev/null 2>&1; then
	export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/ripgreprc
	export FZF_DEFAULT_COMMAND='rg --files --no-messages'
	export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

if which fd >/dev/null 2>&1; then
	FD_DEFAULT_COMMAND='fd --color=always --hidden --follow --no-ignore-vcs'
	export FZF_ALT_C_COMMAND="${FD_DEFAULT_COMMAND} --type directory"

	if [ -z "$FZF_CTRL_T_COMMAND" ]; then
		export FZF_CTRL_T_COMMAND="${FD_DEFAULT_COMMAND} --type file --type symlink"
	fi
fi

# -------------------------------------------------------------------
# jump
# -------------------------------------------------------------------

if which zoxide >/dev/null 2>&1; then
	export _ZO_DATA_DIR=$XDG_DATA_HOME
fi

[ -s "$HOME/bin/cloud_functions.sh" ] && source "$HOME/bin/cloud_functions.sh"

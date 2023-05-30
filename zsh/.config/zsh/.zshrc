#!/usr/bin/env zsh

# `.zshrc' is sourced in interactive shells. It should contain commands to set up aliases, functions, options, key
# bindings, etc.

# Set a custom path for the completion dump file.
zstyle ':zim:completion' dumpfile "${XDG_CACHE_HOME}/zsh/.zcompdump-${ZSH_VERSION}"

# Enable double-dot parent directory expansion.
zstyle ':zim:input' double-dot-expand yes

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-${HOME}}/.zimrc" ]]; then
  source "${ZIM_HOME}/zimfw.zsh" init -q
fi

source "${ZIM_HOME}/init.zsh"

# Post-init module configuration {{{
#
# zsh-history-substring-search
#
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi
# bindkey '^P' history-substring-search-up
# bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# }}}

if (( ${+commands[zoxide]} )); then
  _evalcache zoxide init zsh
fi

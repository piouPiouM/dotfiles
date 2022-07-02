#!/usr/bin/env zsh

# `.zshrc' is sourced in interactive shells. It should contain commands to set up aliases, functions, options, key
# bindings, etc.

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Save timestamp of command and duration.
setopt EXTENDED_HISTORY

# When trimming history, lose oldest duplicates first.
setopt HIST_EXPIRE_DUPS_FIRST

# Disable spelling correction for arguments.
unsetopt CORRECT_ALL

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Set a custom path for the completion dump file.
zstyle ':zim:completion' dumpfile "${XDG_CACHE_HOME}/zsh/.zcompdump-${ZSH_VERSION}"

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

if which zoxide >/dev/null 2>&1; then
  _evalcache zoxide init zsh
fi

# [ -s "$HOME/bin/cloud_functions.sh" ] && source "$HOME/bin/cloud_functions.sh"


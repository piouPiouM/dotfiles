# -------------------------------------------------------------------
# Set options and environment settings after zimfw/environment.
# -------------------------------------------------------------------

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

HISTSIZE=50000
SAVEHIST=30000

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

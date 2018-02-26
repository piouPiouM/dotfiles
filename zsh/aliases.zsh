# Use nocorrect alias to prevent auto correct from "fixing" these
alias sudo='nocorrect sudo'

# Directory movement
alias ..='cd ..'
alias ...='cd ../..'
alias ls="ls -F"
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias exa='exa --color-scale --git --group-directories-first --long --group --all'
alias le='exa -I .git'
alias lg='exa --git-ignore -I .git'

# Editors
alias vim=nvim
alias v=vim
alias view='vim -R'

# Tools
alias mux='tmuxinator'


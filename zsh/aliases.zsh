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
alias vi=nvim
alias v=nvim
alias view='nvim -R'

# Tools
alias idimensions='identify -format "%f: %G\n"'
alias samlcredential='saml2aws login --skip-prompt'
alias nerdfonts='fc-list : family | rg -i nerd'

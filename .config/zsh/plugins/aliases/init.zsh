# Use nocorrect alias to prevent auto correct from "fixing" these
alias sudo="nocorrect sudo"

# Useful in Vi mode
alias :q="exit"

# Editors
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias view="nvim -R"
alias dotfiles="nvim $HOME/.dotfiles"

# Tools
alias gitui="gitui -t $XDG_CONFIG_HOME/gitui/theme-catppuccin.ron"
alias gu="gitui"
alias idimensions='identify -format "%f: %G\n"'
alias nerdfonts='fc-list : family | rg -i nerd'
alias samlcredential='saml2aws login --skip-prompt'
alias zim="zimfw"

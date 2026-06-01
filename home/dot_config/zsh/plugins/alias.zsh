# Use nocorrect alias to prevent auto correct from "fixing" these
# The trailing space allow to the following word to be interpreted as an alias.
alias sudo="nocorrect sudo "

if (( ${+commands[safe-rm]} && ! ${+commands[safe-rmdir]} )); then
  alias rm=safe-rm
fi

# Useful in Vi mode
alias :q="exit"

# Editors
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias view="nvim -R"

# New defaults
alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'
alias grep='grep --color=auto'
alias ls='ls --group-directories-first --color=auto'

# Shortcuts
alias df='df -h'
alias du='du -h'
alias ll='ls -lh'         # long format and human-readable sizes
alias l='ll -A'           # long format, all files
alias lm="l | ${PAGER}"   # long format, all files, use pager
alias lk='ll -Sr'         # long format, largest file size last
alias lt='ll -tr'         # long format, newest modification time last

if (( ${+commands[lsd]} )); then
  alias ls=lsd
  alias lr='ll --tree'    # long format, recursive as a tree
  alias lx='ll -X'        # long format, sort by extension
else
  alias lr='ll -R'        # long format, recursive
  alias lc='lt -c'        # long format, newest status change (ctime) last, not supported by lsd
fi

# Tools
alias idimensions='identify -format "%f: %G\n"'
alias nerdfonts='fc-list : family | rg -i nerd'
alias nerdfontsfix='nerdfix fix --quiet $(fd -t f --hidden "$@")'
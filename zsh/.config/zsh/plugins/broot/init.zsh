if (( ! ${+commands[broot]} )); then
  return 1
fi

alias lb='br --permissions'
alias lbg='br --permissions --show-git-info'

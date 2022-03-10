if (( ! ${+commands[broot]} )); then
  return 1
fi

alias l='br --permissions'
alias lg='br --permissions --show-git-info'

if (( ! ${+commands[fzf]} )); then
  return 1
fi

if (( ${+commands[fd]} )); then
  export FZF_DEFAULT_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -tf'
  export FZF_ALT_C_COMMAND='command fd -c always -H --no-ignore-vcs -E .git -td'

  _fzf_compgen_path() {
    command fd -c always -H --no-ignore-vcs -E .git -tf . "${1}"
  }

  _fzf_compgen_dir() {
    command fd -c always -H --no-ignore-vcs -E .git -td . "${1}"
  }

  export FZF_DEFAULT_OPTS="--ansi ${FZF_DEFAULT_OPTS}"
elif (( ${+commands[rg]} )); then
  export FZF_DEFAULT_COMMAND="command rg -uu -g '!.git' --files"

  _fzf_compgen_path() {
    command rg -uu -g '!.git' --files "${1}"
  }
fi

if (( ${+commands[bat]} )); then
  export FZF_CTRL_T_OPTS="--preview 'command bat --color=always --line-range :500 {}' ${FZF_CTRL_T_OPTS}"
fi

if (( ${+FZF_DEFAULT_COMMAND} )); then
  export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}
fi

local fzf_boot_file="${XDG_CONFIG_HOME}/fzf/fzf.zsh"
[ -f fzf_boot_file ] && source fzf_boot_file

unset fzf_boot_file


# FZF_PREWIEW_OPTS='(bat {} || highlight -O ansi -f --replace-tabs=2 {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null'

# FZF_DEFAULT_OPTS='--multi --inline-info --cycle --tabstop=2 --color gutter:-1'

# # Iceberg theme
# FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#   --color fg:#c6c8d1,bg:#161821,hl:#e2a478,fg+:#cdd1e6,bg+:#2a3158,hl+:#e27878
#   --color info:#a093c7,prompt:#818596,spinner:#b4be82
#   --color pointer:#e27878,marker:#89b8c2,header:#6b7089
# '
# export FZF_DEFAULT_OPTS
# export FZF_CTRL_T_OPTS="--preview '${FZF_PREWIEW_OPTS}' --height 70%"
# export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# if which rg >/dev/null 2>&1; then
#   export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/ripgreprc
#   export FZF_DEFAULT_COMMAND='rg --files --no-messages'
#   export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
# fi

# if which fd >/dev/null 2>&1; then
#   FD_DEFAULT_COMMAND='fd --color=always --hidden --follow --no-ignore-vcs'
#   export FZF_ALT_C_COMMAND="${FD_DEFAULT_COMMAND} --type directory"

#   if [ -z "$FZF_CTRL_T_COMMAND" ]; then
#     export FZF_CTRL_T_COMMAND="${FD_DEFAULT_COMMAND} --type file --type symlink"
#   fi
# fi

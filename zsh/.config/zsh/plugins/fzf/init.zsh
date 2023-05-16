# Rely on configuration added by https://github.com/unixorn/fzf-zsh-plugin

if ! command_exist fzf; then
  return 0
fi

_fzf_preview() {
  local -r preview_file='([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {}))'
  local -r preview_dir='([[ -d {} ]] && (tree -C {} | less))'
  local -r preview_fallback='echo {} 2>/dev/null | head -n 200'

  echo "${preview_file} || ${preview_dir} || ${preview_fallback}"
}

[[ -z "$FZF_PREVIEW" ]]        && export FZF_PREVIEW="$(_fzf_preview)"
# [[ -z "$FZF_PREVIEW_WINDOW" ]] && export FZF_PREVIEW_WINDOW=':hidden'
  # "--preview-window='${FZF_PREVIEW_WINDOW}'"

_fzf_default_opts+=(
  "--layout=reverse"
  "--info=inline"
  "--height=80%"
  "--multi"
  "--preview='${FZF_PREVIEW}'"
  "--prompt='  '"
  "--pointer='󰅂'"
  "--marker='✓'"
  "--bind 'ctrl-p:toggle-preview'"
  "--bind 'ctrl-a:select-all'"
  "--bind 'ctrl-e:execute(${EDITOR} {+} >/dev/tty)'"
  "--bind 'ctrl-v:execute(code {+})'"
)

if command_exist pbcopy; then
  # On Linux we can alias pbcopy to `xclip -selection clipboard` or corresponding tool.
  _fzf_default_opts+=("--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'")
fi

# Word splitting: https://stackoverflow.com/a/32186224
typeset -a _fzf_theme=( ${=FZF_THEME} )
_fzf_default_opts+=("${_fzf_theme[@]}")

export FZF_DEFAULT_OPTS=$(printf '%s\n' "${_fzf_default_opts[@]}")
export FZF_DEFAULT_COMMAND="fd ${FD_DEFAULT_OPTS} --follow"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"

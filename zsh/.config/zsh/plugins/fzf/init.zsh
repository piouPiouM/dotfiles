# Rely on configuration added by https://github.com/unixorn/fzf-zsh-plugin

if ! command_exist fzf; then
  return 0
fi







# From https://github.com/unixorn/fzf-zsh-plugin/blob/19a22259ee62a2f01541f8ef8d9942529f70c690/fzf-zsh-plugin.plugin.zsh#L95
_fzf_preview() {


  foolproofPreview='([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2>/dev/null | head -n 200'
  local preview
  [[ "$FZF_PREVIEW_ADVANCED" == true ]] \
    && preview="lessfilter-fzf {}" \
    || preview="$foolproofPreview"
  echo "$preview"
}

[[ -z "$FZF_PREVIEW" ]]        && export FZF_PREVIEW="$(_fzf_preview)"
[[ -z "$FZF_PREVIEW_WINDOW" ]] && export FZF_PREVIEW_WINDOW=':hidden'

_fzf_default_opts+=(
  "--layout=reverse"
  "--info=inline"
  "--height=80%"
  "--multi"
  "--preview='${FZF_PREVIEW}'"
  "--preview-window='${FZF_PREVIEW_WINDOW}'"
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

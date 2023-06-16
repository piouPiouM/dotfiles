export GREP_COLORS="mt=30;45"
export GREP_COLOR="$GREP_COLORS"

local -r _mode="$(<$HOME/.theme)" 2> /dev/null

if [[ $? -ne 0 ]]; then
  echo "No theme found. Run `make link-home` from the dotfiles root directory." >&2
  return 1
fi

source "$XDG_DATA_HOME/bin/colorscheme" "$_mode" >/dev/null
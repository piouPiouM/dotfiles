local -r _mode="$(<$HOME/.theme)" 2> /dev/null

if [[ $? -ne 0 ]]; then
  echo "No theme found. Run `make link-home` from the dotfiles root directory."
  return 1
fi

typeset -Ar _mode_map=(
  "dark" "catppuccin-mocha"
  "light" "catppuccin-latte"
  "soft-dark" "rose-pine"
  "soft-light" "rose-pine-dawn"
)

if [[ -z $_mode_map[$_mode] ]]; then
  echo "Unknown mode '${_mode}' given. Use one of ${(k)_mode_map}."
  return 1
fi

local -r _theme="${_mode_map[$_mode]}"

export PPM_THEME=$_theme

theme-bat $_theme
theme-fzf $_theme
theme-lazygit $_theme

local -r _mode="$(<$HOME/.theme)" 2> /dev/null

if [[ $? -ne 0 ]]; then
  echo "No theme found. Run `make link-home` from the dotfiles root directory."
  return 1
fi

colorscheme "$_mode"

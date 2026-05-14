_fd_default_opts+=(
  "--hidden"          # Include hidden directories and files in the search results.
  "--no-require-git"  # Do not require a git repository to respect gitignores.
  "--one-file-system" # Prevent traversing other filesystem.
)

export FD_DEFAULT_OPTS="${_fd_default_opts[@]}"

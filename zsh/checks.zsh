[ ! -d $XDG_CACHE_HOME/zsh ] && mkdir $XDG_CACHE_HOME/zsh
[ ! -d $XDG_DATA_HOME/zsh ] && mkdir $XDG_DATA_HOME/zsh

if hash fasd 2>/dev/null; then
  fasd_cache="${XDG_CACHE_HOME}/zsh/fasd-init-cache"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
  fi

  source "$fasd_cache"
  unset fasd_cache
fi


export ZPLUG_HOME="$PPM_BREW_PREFIX/opt/zplug"
export ZPLUG_LOADFILE=$XDG_CONFIG_HOME/zplug/packages.zsh

source $ZPLUG_HOME/init.zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

# zplug breaks the ZSH job management.
# See https://github.com/zplug/zplug/issues/374
[ -f $_zplug_lock ] && rm $_zplug_lock

# Then, source plugins and add commands to $PATH
zplug load

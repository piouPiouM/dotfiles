export ZPLUG_HOME=$XDG_DATA_HOME/zplug
export ZPLUG_CACHE_DIR=$XDG_CACHE_HOME/zplug
export ZPLUG_LOADFILE=$XDG_CONFIG_HOME/zplug/packages.zsh

[ ! -d $XDG_CONFIG_HOME/zplug ] && mkdir $XDG_CONFIG_HOME/zplug

# Check if zplug is installed
if [[ ! -d $ZPLUG_HOME/zplug ]]; then
  echo "zplug is missing. Launch install."
  git clone https://github.com/zplug/zplug $ZPLUG_HOME/zplug
  source $ZPLUG_HOME/zplug/init.zsh && zplug install
fi
source $ZPLUG_HOME/zplug/init.zsh

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


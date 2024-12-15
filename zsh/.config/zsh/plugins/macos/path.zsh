PPM_BREW_PREFIX=/opt/homebrew

_GEM_HOME="$("${PPM_BREW_PREFIX}"/opt/ruby/bin/gem environment user_gemhome 2>/dev/null)"

path+=(
  "$PPM_BREW_PREFIX"/bin
  "$PPM_BREW_PREFIX"/opt/ruby/bin
  "$PPM_BREW_PREFIX"/opt/curl/bin
)
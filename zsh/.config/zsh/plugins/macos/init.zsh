() {
  emulate -L zsh

  # Opt out
  export HOMEBREW_NO_ANALYTICS=1

  # Avoid long-running Homebrew commands being killed due to no output.
  export HOMEBREW_VERBOSE_USING_DOTS=1

  # Avoids calling the `brew -prefix` command repeatedly.
  export PPM_BREW_PREFIX=/opt/homebrew

  # Useful for Packer's Hererocks (nvim)
  export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion)

  LDFLAGS="-L${PPM_BREW_PREFIX}/opt/curl/lib ${LDFLAGS}"
  CPPFLAGS="-I${PPM_BREW_PREFIX}/opt/curl/include ${CPPFLAGS}"
  LDFLAGS="-L${PPM_BREW_PREFIX}/opt/ruby/lib ${LDFLAGS}"
  CPPFLAGS="-I${PPM_BREW_PREFIX}/opt/ruby/include ${CPPFLAGS}"
  LDFLAGS="-L${PPM_BREW_PREFIX}/opt/luajit-openresty/lib ${LDFLAGS}"
  CPPFLAGS="-I${PPM_BREW_PREFIX}/opt/luajit-openresty/include ${CPPFLAGS}"
  LDFLAGS="-L${PPM_BREW_PREFIX}/opt/libgit2@1.7/lib ${LDFLAGS}"
  CPPFLAGS="-I${PPM_BREW_PREFIX}/opt/libgit2@1.7/include ${CPPFLAGS}"

  export LDFLAGS
  export CPPFLAGS
  export PKG_CONFIG_PATH="${PPM_BREW_PREFIX}/opt/luajit-openresty/lib/pkgconfig:${PPM_BREW_PREFIX}/opt/libgit2@1.7/lib/pkgconfig:${PKG_CONFIG_PATH}"

  alias -g ls='ls --color=auto'

  alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
  alias flush-downloads="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
  alias list-downloads="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | sort"
}
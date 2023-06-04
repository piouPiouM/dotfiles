() {
  emulate -L zsh

  # Opt out
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_GOOGLE_ANALYTICS=1

  # Avoid long-running Homebrew commands being killed due to no output.
  export HOMEBREW_VERBOSE_USING_DOTS=1

  # Avoids calling the `brew -prefix` command repeatedly.
  export PPM_BREW_PREFIX=/usr/local

  # Useful for Packer's Hererocks (nvim)
  export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion)

  LDFLAGS="-L${PPM_BREW_PREFIX}/opt/curl/lib ${LDFLAGS}"
  CPPFLAGS="-I${PPM_BREW_PREFIX}/opt/curl/include ${CPPFLAGS}"
  LDFLAGS="-L${PPM_BREW_PREFIX}/opt/ruby/lib ${LDFLAGS}"
  CPPFLAGS="-I${PPM_BREW_PREFIX}/opt/ruby/include ${CPPFLAGS}"

  export LDFLAGS
  export CPPFLAGS

  path+=(
    "$HOME"/.gem/ruby/2.6.0/bin
    $PPM_BREW_PREFIX/opt/ruby/bin
    $PPM_BREW_PREFIX/opt/curl/bin
  )
  typeset -gU path

  # Replace the built-in `ls` with the coreutils `ls` to benefit from
  # Kitty's hyperlink support.
  alias -g ls='ls --hyperlink=auto --color=auto --classify=auto'

  alias flush-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
  alias flush-downloads="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
  alias list-downloads="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent' | sort"
}

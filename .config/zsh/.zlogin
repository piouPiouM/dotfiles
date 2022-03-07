#!/usr/bin/env zsh

# `.zlogin' is sourced in login shells. It should contain commands that should be executed only in login shells.
# `.zlogin' is not the place for alias definitions, options, environment variable settings, etc.; as a general rule, it
# should not change the shell environment at all. Rather, it should be used to set the terminal type and run a series of
# external commands (fortune, msgs, etc).

# setopt LOCAL_OPTIONS EXTENDED_GLOB

# Execute code in the background to not affect the current session
# (
#   autoload -U zrecompile

#   for f in "${ZDOTDIR}/**/*.*sh"
#   do
#       zrecompile -pq $f
#   done
# ) &!

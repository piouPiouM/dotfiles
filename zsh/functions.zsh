# -------------------------------------------------------------------
# display the top process in CPU usage
# -------------------------------------------------------------------
topprocess() {
  ps -xarco pid=,%cpu=,command= | head -1 | awk '{if($2!=0.0) print $3 " (" $2 "%)"}'
}

# -------------------------------------------------------------------
# Dash functions
# -------------------------------------------------------------------
# Open argument in Dash
dash() {
  open dash://$*
}

dman() {
  open dash://man:$*
}

dphp() {
  open dash://php:$*
}

# -------------------------------------------------------------------
# display a neatly formatted path.
# From https://github.com/zanshin/dotfiles
# -------------------------------------------------------------------
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",    \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",    \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",    \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",   \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\",  \"$fg_no_bold[yellow]/local$reset_color\"); \
           sub(\"/.local\", \"$fg_no_bold[yellow]/.local$reset_color\"); \
           sub(\"/.rvm\",   \"$fg_no_bold[red]/.rvm$reset_color\"); \
           print }"
}

# -------------------------------------------------------------------
# display a neatly formatted fpath.
# From https://github.com/zanshin/dotfiles
# -------------------------------------------------------------------
fpath() {
  print -rl -- $fpath | \
    awk "{ sub(\"/usr\",    \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",    \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",    \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",   \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\",  \"$fg_no_bold[yellow]/local$reset_color\"); \
           sub(\"/.local\", \"$fg_no_bold[yellow]/.local$reset_color\"); \
           sub(\"/.rvm\",   \"$fg_no_bold[red]/.rvm$reset_color\"); \
           print }"
}

# -------------------------------------------------------------------
# myIP address.
# From https://github.com/zanshin/dotfiles
# -------------------------------------------------------------------
myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# -------------------------------------------------------------------
# fe [FUZZY PATTERN] - Open the selected file with the default editor
# -------------------------------------------------------------------
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  echo "$files"
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# -------------------------------------------------------------------
# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
# -------------------------------------------------------------------
fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# -------------------------------------------------------------------
# From https://github.com/junegunn/fzf/wiki/Examples#z
# -------------------------------------------------------------------
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux --height 25% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# -------------------------------------------------------------------
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
# -------------------------------------------------------------------
bip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# -------------------------------------------------------------------
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
# -------------------------------------------------------------------
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# -------------------------------------------------------------------
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
# -------------------------------------------------------------------
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}


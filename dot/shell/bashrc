#!/usr/bin/env bash

# Alias fonctionnels
alias ls="ls -GF"
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lah"
alias df="df -h"

alias vim="nvim"
alias r="ranger"

# Alias de commandes
alias bashrc="nvim $HOME/.bashrc && source $HOME/.bash_profile"
alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'
alias sha1sum="openssl dgst -sha1"
alias drushcc="for i in {1..3}; do drush cc all; done"
alias acksed="_ack_substitute $@"
alias ackdd="ack '\b(var_dump|dpm|kpr|dd|dargs|console\.log)' $@"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Accès rapide
alias www="cd /var/www/"
alias wwww="cd /var/www/htdocs/"
alias wwwsandbox="cd /var/www/sandbox/"
alias slap="afplay -t 4.4 ~/Pictures/lol/slap.mp4"
################################################################
# Check if the given argument is a known command
#
_fn_exists() {
	declare -f $1 >/dev/null
}

# https://gist.github.com/florianbeer/ee02c149a7e25f643491
ssh() {
	if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
		tmux rename-window "  $(echo $* | cut -d . -f 1)"
		command ssh "$@"
		tmux set-window-option automatic-rename "on" 1>/dev/null
	else
		command ssh "$@"
	fi
}

################################################################
# Search and replace with Ack.
#
# https://gist.github.com/evansd/1639992
#
_ack_substitute() {
	if [ -z "$1" -o -z "$2" ]; then
		echo "Usage: substitue FROM_STRING TO_STRING [OPTION]..."
		echo
		echo "Replace all occurances of FROM_STRING (a sed-compatible regular"
		echo "expression) with TO_STRING in all files for which ack-grep matches"
		echo "FROM_STRING."
		echo
		echo "Any additional options are passed directly to ack-grep (e.g.,"
		echo " --type=html would only run the substitution on html files)."
		return 1
	fi
	# Escape forward slashes for sed
	FROM_STRING=${1/\//\\/}
	TO_STRING=${2/\//\\/}
	shift 2
	ack -l --print0 "$@" "$FROM_STRING" | xargs -0 -n 1 sed -i -e "s/$FROM_STRING/$TO_STRING/g"
}

################################################################
# pre-prompt pour calculer le titre du xterm
#
_preprompt() {
	# lancee avant le prompt
	WHOAMI=$(whoami)
	export WINTITLE="$HOSTNAME/$WHOAMI   $PWD"

	# Selon le type de terminal...
	case "$TERM$NEXTCONSOLE" in
	xterm* | *YES | vt100*)
		# avant chaque prompt, affiche le chemin courant dans la barre de titre
		echo -ne "\033]0;$WINTITLE  \007\c"
		;;
	esac
}
PROMPT_COMMAND=_preprompt

# ##################################################################
# prompt
#
_prompt() {
	if [ $UID -eq 0 ]; then
		# The # character serves as an extra reminder that I am root
		SYM='#'
	else
		SYM='$'
	fi

	# Regular
	BLACK="\[\033[0;30m\]"
	RED="\[\033[0;31m\]"
	GREEN="\[\033[0;32m\]"
	YELLOW="\[\033[0;33m\]"
	BLUE="\[\033[0;34m\]"
	PURPLE="\[\033[0;35m\]"
	CYAN="\[\033[0;36m\]"
	WHITE="\[\033[0;37m\]"

	# Bold
	BBLACK="\[\033[1;30m\]"
	BRED="\[\033[1;31m\]"
	BGREEN="\[\033[1;32m\]"
	BYELLOW="\[\033[1;33m\]"
	BBLUE="\[\033[1;34m\]"
	BPURPLE="\[\033[1;35m\]"
	BCYAN="\[\033[1;36m\]"
	BWHITE="\[\033[1;37m\]"

	# Underline
	UBLACK="\[\033[4;30m\]"
	URED="\[\033[4;31m\]"
	UGREEN="\[\033[4;32m\]"
	UYELLOW="\[\033[4;33m\]"
	UBLUE="\[\033[4;34m\]"
	UPURPLE="\[\033[4;35m\]"
	UCYAN="\[\033[4;36m\]"
	UWHITE="\[\033[4;37m\]"

	# Background
	BGBLACK="\[\033[40m\]"
	BGRED="\[\033[41m\]"
	BGGEEEN="\[\033[42m\]"
	BGYELLOW="\[\033[43m\]"
	BGBLUE="\[\033[44m\]"
	BGPURPLE="\[\033[45m\]"
	BGCYAN="\[\033[46m\]"
	BGWHITE="\[\033[47m\]"

	COLOR_NONE="\[\033[0m\]"
	BOLD="\[\033[1m\]"
	NORMAL="\[\033[m\]"

	if [ -f $PPM_BREW_PREFIX/etc/bash_completion.d/git-prompt.sh ]; then
		source $PPM_BREW_PREFIX/etc/bash_completion.d/git-prompt.sh
	fi

	_fn_exists '__git_ps1'
	if [ $? -eq 0 ]; then
		export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
		export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch
		G="\$(__git_ps1 \"${UPURPLE}%s${NORMAL}:\")"
	else
		G=''
	fi
	P1="[\A] (${G}${GREEN}\w${NORMAL})\n${BOLD}\u${NORMAL}@${BOLD}\h${NORMAL} ${SYM}${COLOR_NONE} "

	export PS1="$P1"
}
_prompt

# fzf
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash

source $XDG_CONFIG_HOME/broot/launcher/bash/br

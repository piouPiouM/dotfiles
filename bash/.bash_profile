#!/usr/bin/env bash

if [ -f "$HOME/.profile" ]; then
	source $HOME/.profile
fi

if [ -f "$HOME/.bashrc" ]; then
	source $HOME/.bashrc
fi

export USER_BASH_COMPLETION_DIR=~/.bash_completion.d
if [ -f $PPM_BREW_PREFIX/etc/bash_completion ]; then
	. $PPM_BREW_PREFIX/etc/bash_completion
fi

source /Users/mkabab/.config/broot/launcher/bash/br

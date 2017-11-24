# === Basics

setopt no_beep # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells


# === Changing directories

setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack


# === Expansion and globbing

setopt extended_glob # treat #, ~, and ^ as part of patterns for filename generation
setopt nonomatch # try to avoid the 'zsh: no matches found...'


# === History

setopt append_history # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history # save timestamp of command and duration
#setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt hist_verify # don't execute, just expand history
setopt share_history # imports new commands and appends typed commands to history


# === Completion

setopt always_to_end # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase
setopt hash_list_all # whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt noshwordsplit # use zsh style word splitting

unsetopt menu_complete # do not autoselect the first completion entry


# === Correction

unsetopt correct_all # spelling correction for arguments
setopt correct # spelling correction for commands


# === Prompt

setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt


# === Input/Output

setopt noflowcontrol # no c-s/c-q output freezing


# === Job Control

setopt longlistjobs # display PID when suspending processes as well
setopt notify # report the status of backgrounds jobs immediately


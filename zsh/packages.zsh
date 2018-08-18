zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme         # deps: zsh-async
zplug "zsh-users/zsh-syntax-highlighting", defer:2        # commandline syntax highlighting
zplug "Tarrasch/zsh-bd"                                   # go back to a parent directory
zplug "ael-code/zsh-colored-man-pages"                    # colored man pages
zplug "changyuheng/zsh-interactive-cd"                    # fzf + fish like cd tab completion
zplug "zsh-users/zsh-autosuggestions"                     # suggest from history

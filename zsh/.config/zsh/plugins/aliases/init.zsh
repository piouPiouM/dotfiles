() {
  emulate -RL zsh

  # Use nocorrect alias to prevent auto correct from "fixing" these
  # The trailing space allow to the following word to be interpreted as an alias.
  alias sudo="nocorrect sudo "

  # Useful in Vi mode
  alias :q="exit"

  # Editors
  alias vim="nvim"
  alias vi="nvim"
  alias v="nvim"
  alias view="nvim -R"
  alias dotfiles="cd $HOME/.dotfiles && $EDITOR; cd -"

  # Files and directory
  alias ll="ls -Glah"

  # Tools
  alias icat="kitty +kitten icat --align=left"
  alias idimensions='identify -format "%f: %G\n"'
  alias nerdfonts='fc-list : family | rg -i nerd'
  alias samlcredential='saml2aws login --skip-prompt'
  alias zim="zimfw"
}

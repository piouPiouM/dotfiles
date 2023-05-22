My dotfiles 🍺


## FAQ

### zsh compinit: insecure directories, run compaudit for list.

```sh
compaudit | xargs chmod g-w
```

### Error `trash: error -1701`

If you get this error when using Kitty, you need to reset the Finder access permissions using the following command. A
confirmation prompt will be displayed the next time you run the `trash` command.

```sh
tccutil reset AppleEvents net.kovidgoyal.kitty
```

Thx to [@gsbabil](https://github.com/ali-rantakari/trash/issues/37#issuecomment-1104788438) for the tip!

# kitty

## FAQ

### How to find JetBrainsMono fonts on my system?

```sh
kitty +list-fonts --psnames | grep JetBrainsMono
```

### How to find Nerd fonts on my system?

```sh
fc-list : family | rg -i nerd
```

> **Note**
> I have a custom alias for this: `nerdfonts`
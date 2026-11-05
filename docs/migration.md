# Migration stow → chezmoi : état des lieux

Relevé du 2026-11-04 sur la machine Ubuntu 26.04. Il compare `$HOME` aux branches `work` (`eb94502`) et `chezmoi` (`bf7a58a`, identique à `origin/chezmoi`).

`chezmoi init` n'a jamais été lancé : `~/.config/chezmoi/` n'existe pas. Un fichier de `$HOME` identique à une branche y a donc été copié à la main, ou vient encore d'un lien stow vers `~/.dotfiles`.

## Points d'attention

1. `~/.dotfiles` a 59 changements non commités : 35 fichiers modifiés et 24 non suivis, dont 17 fichiers de télémétrie Go. Les fichiers servis par un lien stow incluent ces changements. Pour réconcilier, la référence est donc `$HOME`, pas l'historique git.
2. `~/.config/git/` est un lien vers `~/.dotfiles`. La config git active vient de l'ancien dépôt et a 2 fichiers non commités.
3. `.chezmoiignore` exclut `~/.config/niri` sur Ubuntu, alors que niri et Noctalia tournent ici. `~/.config/niri/` est un dépôt git à part, très différent de `work` (+632 / −297 sur `config.kdl`). `work` embarque encore `dms/` (DankMaterialShell).
4. Trois liens parasites sont à la racine de `$HOME` : `~/assets`, `~/checks.zsh`, `~/copilot-models.lua` (section 2).
5. Dans la branche `chezmoi`, `private_ssh/config.tmpl` vise `~/ssh/config` au lieu de `~/.ssh/config` : il manque `dot_`.

## Méthode et légende

- Rendu : `chezmoi archive` (chezmoi 2.73.2 via mise), avec une config temporaire (`purpose = "hackuity"`), sans externals ni scripts. Rien n'a été écrit dans `$HOME`.
- `[x]` : rien à faire. `[ ]` : à migrer ou à réconcilier.
- `+N / −M` : lignes en plus / en moins dans `$HOME` par rapport à la branche.
- `~/dossier/ (N fichiers)` regroupe des fichiers qui sont tous dans le même état.
- 5 fichiers sont vides dans la source et n'ont pas le préfixe `empty_` : `nvim/lua/ppm/toolkit/color/init.lua`, `zsh/rc.sample.zsh` et `niri/dms/{cursor,outputs,windowrules}.kdl`. Ils manquent dans les comptes ci-dessous, et `chezmoi apply` supprimerait leurs équivalents vides dans `$HOME` (section 4.1).
- Hors relevé : les externals (thèmes Catppuccin, thèmes kitty, polices) et les scripts `.chezmoiscripts/`. Ils s'exécutent au premier `chezmoi apply`.

## 1. Branche `work` : état dans `$HOME`

Sur Ubuntu, `work` gère 304 cibles : 263 identiques, 27 différents, 14 absents de `$HOME`.

### 1.1 Copiés à la main, identiques

- [x] `~/.config/environment.d/991-mise.conf` — identique

### 1.2 Copiés à la main, à réconcilier

- [ ] `~/.config/btop/btop.conf` — différent (+26 / −48)
- [ ] `~/.config/mise/config.toml` — différent (+23 / −89)

### 1.3 Absents de `$HOME`

- [ ] `~/.config/DankMaterialShell/` (2 fichiers) — absents de `$HOME`
- [ ] `~/.config/containers/containers.conf` — absent de `$HOME`
- [ ] `~/.config/eget.toml` — absent de `$HOME`
- [ ] `~/.config/fontconfig/fonts.conf` — absent de `$HOME`
- [ ] `~/.config/hledger/hledger.conf` — absent de `$HOME`
- [ ] `~/.config/rofi/config.rasi` — absent de `$HOME`
- [ ] `~/.config/yazi/` (5 fichiers) — absents de `$HOME`
- [ ] `~/.config/zathura/zathurarc` — absent de `$HOME`

### 1.4 Encore servis par un lien stow

288 cibles passent encore par un lien vers `~/.dotfiles`. Le détail est en section 2, lien par lien.

### 1.5 Ignorés sur Ubuntu par `.chezmoiignore`

Ces fichiers sont dans la source, mais `chezmoi apply` ne les écrira pas sur cette machine.

- [ ] `~/.config/environment.d/wayland.conf` — absent de `$HOME`
- [ ] `~/.config/niri/config.kdl` — différent (+632 / −297)
- [ ] `~/.config/niri/dms/` (5 fichiers) — absents de `$HOME`
- [ ] `~/.config/sway/` (15 fichiers) — absents de `$HOME`
- [ ] `~/.config/swaylock/config` — absent de `$HOME`
- [ ] `~/.config/swaync/` (2 fichiers) — absents de `$HOME`
- [ ] `~/.config/waybar/` (3 fichiers) — absents de `$HOME`
- [ ] `~/.local/share/terraform/.terraformrc` — absent de `$HOME`

## 2. Liens de `$HOME` vers `~/.dotfiles`

Ce sont les liens posés par stow. Cocher un lien quand il est supprimé et que `chezmoi apply` a écrit les vrais fichiers. Sous chaque lien : les fichiers de `work` qui ne sont pas identiques. « non commités » : modifications de `~/.dotfiles` qui n'existent que sur le disque.

- [ ] `~/.config/atuin/` → `../.dotfiles/atuin/.config/atuin` — `work` : 1 identique
- [ ] `~/.config/bat/` → `../.dotfiles/bat/.config/bat` — `work` : 1 identique
- [ ] `~/.config/direnv/` → `../.dotfiles/direnv/.config/direnv` — `work` : 1 identique
- [ ] `~/.config/efm-langserver/` → `../.dotfiles/nvim/.config/efm-langserver` — `work` : 1 identique
- [ ] `~/.config/fd/` → `../.dotfiles/fd/.config/fd` — `work` : 1 identique
- [ ] `~/.config/git/` → `../.dotfiles/git/.config/git` — `work` : 2 différents · non commités : 2 modifié(s)
  - [ ] `~/.config/git/config` — différent (+34 / −66)
  - [ ] `~/.config/git/ignore` — différent (+15 / −0)
- [ ] `~/.config/go/` → `../.dotfiles/go/.config/go` — `work` : 1 identique · non commités : 17 non suivi(s)
- [ ] `~/.config/kitty/.ignore` → `../../.dotfiles/kitty/.config/kitty/.ignore` — **absent de `work`** (voir 4.1)
- [ ] `~/.config/kitty/dark-theme.auto.conf` → `../../.dotfiles/kitty/.config/kitty/dark-theme.auto.conf` — `work` : 1 identique
- [ ] `~/.config/kitty/kitty-linux.conf` → `../../.dotfiles/kitty/.config/kitty/kitty-linux.conf` — **absent de `work`** (voir 4.1) · non commités : 1 modifié(s)
- [ ] `~/.config/kitty/kitty-macos.conf` → `../../.dotfiles/kitty/.config/kitty/kitty-macos.conf` — **absent de `work`** (voir 4.1)
- [ ] `~/.config/kitty/kitty.conf` → `../../.dotfiles/kitty/.config/kitty/kitty.conf` — `work` : 1 différent · non commités : 1 modifié(s)
  - [ ] `~/.config/kitty/kitty.conf` — différent (+8 / −7)
- [ ] `~/.config/kitty/light-theme.auto.conf` → `../../.dotfiles/kitty/.config/kitty/light-theme.auto.conf` — `work` : 1 identique
- [ ] `~/.config/kitty/nerd-fonts.conf` → `../../.dotfiles/kitty/.config/kitty/nerd-fonts.conf` — `work` : 1 identique
- [ ] `~/.config/kitty/no-preference-theme.auto.conf` → `../../.dotfiles/kitty/.config/kitty/no-preference-theme.auto.conf` — `work` : 1 identique
- [ ] `~/.config/kitty/open-actions.conf` → `../../.dotfiles/kitty/.config/kitty/open-actions.conf` — `work` : 1 identique
- [ ] `~/.config/kitty/themes/` → `../../.dotfiles/kitty/.config/kitty/themes` — `work` : 1 identique · non commités : 8 modifié(s), 1 non suivi(s)
- [ ] `~/.config/kitty/unicode-input-favorites.conf` → `../../.dotfiles/kitty/.config/kitty/unicode-input-favorites.conf` — `work` : 1 identique
- [ ] `~/.config/lazygit/` → `../.dotfiles/lazygit/.config/lazygit` — `work` : 1 différent · non commités : 1 modifié(s)
  - [ ] `~/.config/lazygit/config.yml` — différent (+1 / −0)
- [ ] `~/.config/luaformatter/` → `../.dotfiles/nvim/.config/luaformatter` — `work` : 1 identique
- [ ] `~/.config/nvim/` → `../.dotfiles/nvim/.config/nvim` — `work` : 194 identiques, 14 différents, 1 absent de `$HOME` · non commités : 13 modifié(s), 1 non suivi(s)
  - [ ] `~/.config/nvim/init.lua` — différent (+13 / −7)
  - [ ] `~/.config/nvim/lazy-lock.json` — différent (+30 / −40)
  - [ ] `~/.config/nvim/lsp/cssls.lua` — différent (+7 / −0)
  - [ ] `~/.config/nvim/lsp/tombi.lua` — absent de `$HOME`
  - [ ] `~/.config/nvim/lua/plugins/ai.lua` — différent (+56 / −56)
  - [ ] `~/.config/nvim/lua/plugins/coding.lua` — différent (+2 / −0)
  - [ ] `~/.config/nvim/lua/plugins/colorscheme.lua` — différent (+5 / −5)
  - [ ] `~/.config/nvim/lua/plugins/syntax.lua` — différent (+0 / −9)
  - [ ] `~/.config/nvim/lua/plugins/treesitter.lua` — différent (+1 / −1)
  - [ ] `~/.config/nvim/lua/ppm/lsp.lua` — différent (+2 / −2)
  - [ ] `~/.config/nvim/lua/ppm/plugin/cmp/filtering.lua` — différent (+1 / −2)
  - [ ] `~/.config/nvim/lua/ppm/plugin/cmp/sorting.lua` — différent (+1 / −1)
  - [ ] `~/.config/nvim/lua/ppm/plugin/lsp/init.lua` — différent (+4 / −4)
  - [ ] `~/.config/nvim/lua/ppm/plugin/lualine.lua` — différent (+36 / −36)
  - [ ] `~/.config/nvim/lua/ppm/plugin/treesitter.lua` — différent (+5 / −12)
- [ ] `~/.config/ripgrep/` → `../.dotfiles/ripgrep/.config/ripgrep` — `work` : 1 identique
- [ ] `~/.config/starship/` → `../.dotfiles/starship/.config/starship` — `work` : 1 différent · non commités : 1 modifié(s)
  - [ ] `~/.config/starship/starship.toml` — différent (+7 / −0)
- [ ] `~/.config/zsh/` → `../.dotfiles/zsh/.config/zsh` — `work` : 17 identiques, 3 différents · non commités : 4 modifié(s), 2 non suivi(s)
  - [ ] `~/.config/zsh/.zlogin` — identique · bit exécutable différent
  - [ ] `~/.config/zsh/.zprofile` — différent (+12 / −2)
  - [ ] `~/.config/zsh/.zshenv` — différent (+5 / −3) · bit exécutable différent
  - [ ] `~/.config/zsh/.zshrc` — différent (+15 / −4) · bit exécutable différent
- [ ] `~/.gemrc` → `.dotfiles/home/dot-gemrc` — `work` : 1 identique
- [ ] `~/.ignore` → `.dotfiles/home/dot-ignore` — `work` : 1 différent
  - [ ] `~/.ignore` — différent (lien attendu → `.config/fd/ignore`)
- [ ] `~/.local/share/bin/archived/` → `../../../.dotfiles/bin/archived` — `work` : 4 identiques
- [ ] `~/.local/share/bin/colorscheme` → `../../../.dotfiles/bin/colorscheme` — `work` : 1 identique
- [ ] `~/.local/share/bin/functions/` → `../../../.dotfiles/bin/functions` — `work` : 6 identiques
- [ ] `~/.local/share/bin/fzf-preview-image` → `../../../.dotfiles/bin/fzf-preview-image` — `work` : 1 identique
- [ ] `~/.local/share/bin/kitty-config-nerd-font` → `../../../.dotfiles/bin/kitty-config-nerd-font` — `work` : 1 identique
- [ ] `~/.local/share/bin/lib/` → `../../../.dotfiles/bin/lib` — `work` : 7 identiques
- [ ] `~/.local/share/bin/linux/` → `../../../.dotfiles/bin/linux` — `work` : 7 identiques, 1 différent · non commités : 1 modifié(s)
  - [ ] `~/.local/share/bin/linux/lua-language-server` — différent (+5 / −2)
- [ ] `~/.local/share/bin/macos/` → `../../../.dotfiles/bin/macos` — **absent de `work`** (voir 4.1)
- [ ] `~/.local/share/bin/nerdfonts-fetch-glyphnames` → `../../../.dotfiles/bin/nerdfonts-fetch-glyphnames` — `work` : 1 identique
- [ ] `~/.local/share/bin/ppm::lib` → `../../../.dotfiles/bin/ppm::lib` — `work` : 1 identique
- [ ] `~/.local/share/bin/trash-deep` → `../../../.dotfiles/bin/trash-deep` — `work` : 1 identique
- [ ] `~/.local/share/bin/venv-upgrade` → `../../../.dotfiles/bin/venv-upgrade` — `work` : 1 identique
- [ ] `~/.local/share/bin/vim-profiler` → `../../../.dotfiles/bin/vim-profiler` — `work` : 1 identique
- [ ] `~/.local/share/fzf/` → `../../.dotfiles/fzf/.local/share/fzf` — **absent de `work`** (voir 4.1)
- [ ] `~/.local/share/git/` → `../../.dotfiles/git/.local/share/git` — **absent de `work`** (voir 4.1) · non commités : 1 modifié(s)
- [ ] `~/.local/share/lazygit/` → `../../.dotfiles/lazygit/.local/share/lazygit` — **absent de `work`** (voir 4.1)
- [ ] `~/.local/share/zsh/` → `../../.dotfiles/zsh/.local/share/zsh` — `work` : 2 identiques · non commités : 3 non suivi(s)
- [ ] `~/.theme` → `.dotfiles/home/dot-theme` — `work` : 1 différent · non commités : 1 modifié(s)
  - [ ] `~/.theme` — différent (+2 / −2)
- [ ] `~/.zshenv` → `.dotfiles/home/dot-zshenv` — `work` : 1 identique
- [ ] `~/assets/` → `.dotfiles/kitty/assets` — ⚠ lien parasite (fichier à la racine d'un paquet stow) : à supprimer
- [ ] `~/checks.zsh` → `.dotfiles/zsh/checks.zsh` — ⚠ lien parasite (fichier à la racine d'un paquet stow) : à supprimer
- [ ] `~/copilot-models.lua` → `.dotfiles/nvim/copilot-models.lua` — ⚠ lien parasite (fichier à la racine d'un paquet stow) : à supprimer

## 3. Branche `chezmoi` : fichiers déjà présents dans `$HOME`

La branche est rendue avec des secrets factices à la place de `.secrets.*`. Le fichier chiffré `~/.private/chezmoi/secrets.yaml.age` est exclu. « = work » / « ≠ work » compare le rendu des deux branches.

280 cibles de `chezmoi` existent dans `$HOME` : 249 identiques, 31 différents.

### 3.1 Différentes de `$HOME`

- [ ] `~/.config/btop/btop.conf` — différent (+26 / −48) · = work
- [ ] `~/.config/git/config` — différent (+46 / −37) · via le lien `~/.config/git` · ≠ work
- [ ] `~/.config/git/ignore` — différent (+15 / −0) · via le lien `~/.config/git` · = work
- [ ] `~/.config/kitty/kitty.conf` — différent (+9 / −8) · via le lien `~/.config/kitty/kitty.conf` · ≠ work
- [ ] `~/.config/lazygit/config.yml` — différent (+1 / −0) · via le lien `~/.config/lazygit` · = work
- [ ] `~/.config/mise/config.toml` — différent (+23 / −115) · ≠ work · contient des secrets (rendu factice)
- [ ] `~/.config/niri/config.kdl` — différent (+632 / −297) · = work · ignoré sur Ubuntu
- [ ] `~/.config/nvim/init.lua` — différent (+13 / −6) · via le lien `~/.config/nvim` · ≠ work
- [ ] `~/.config/nvim/lazy-lock.json` — différent (+30 / −40) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lsp/cssls.lua` — différent (+7 / −0) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/plugins/ai.lua` — différent (+56 / −56) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/plugins/coding.lua` — différent (+2 / −1) · via le lien `~/.config/nvim` · ≠ work
- [ ] `~/.config/nvim/lua/plugins/colorscheme.lua` — différent (+5 / −5) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/plugins/syntax.lua` — différent (+0 / −9) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/plugins/treesitter.lua` — différent (+13 / −19) · via le lien `~/.config/nvim` · ≠ work
- [ ] `~/.config/nvim/lua/ppm/lsp.lua` — différent (+2 / −2) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/ppm/plugin/cmp/filtering.lua` — différent (+1 / −2) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/ppm/plugin/cmp/sorting.lua` — différent (+1 / −1) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/ppm/plugin/copilot.lua` — différent (+1 / −0) · via le lien `~/.config/nvim` · ≠ work
- [ ] `~/.config/nvim/lua/ppm/plugin/lsp/init.lua` — différent (+4 / −27) · via le lien `~/.config/nvim` · ≠ work
- [ ] `~/.config/nvim/lua/ppm/plugin/lualine.lua` — différent (+36 / −36) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/nvim/lua/ppm/plugin/lualine/components/copilot_model.lua` — différent (+9 / −3) · via le lien `~/.config/nvim` · ≠ work
- [ ] `~/.config/nvim/lua/ppm/plugin/treesitter.lua` — différent (+5 / −12) · via le lien `~/.config/nvim` · = work
- [ ] `~/.config/starship/starship.toml` — différent (+58 / −51) · via le lien `~/.config/starship` · ≠ work
- [ ] `~/.config/zsh/.zprofile` — différent (+50 / −136) · via le lien `~/.config/zsh` · ≠ work
- [ ] `~/.config/zsh/.zshenv` — différent (+112 / −7) · bit exécutable différent · via le lien `~/.config/zsh` · ≠ work
- [ ] `~/.config/zsh/.zshrc` — différent (+53 / −201) · bit exécutable différent · via le lien `~/.config/zsh` · ≠ work
- [ ] `~/.ignore` — différent (lien attendu → `.config/fd/ignore`) · via le lien `~/.ignore` · = work
- [ ] `~/.local/share/bin/linux/lua-language-server` — différent (+5 / −2) · via le lien `~/.local/share/bin/linux` · = work
- [ ] `~/.theme` — différent (+2 / −2) · via le lien `~/.theme` · = work
- [ ] `~/.zshenv` — différent (lien attendu → `.config/zsh/.zshenv`) · via le lien `~/.zshenv` · ≠ work

### 3.2 Identiques à `$HOME`

Regroupés par dossier. Coché = copié à la main, rien à faire. Non coché = encore servi par un lien stow.

- [ ] `~/.config/atuin/config.toml` — identique · = work · via un lien stow
- [ ] `~/.config/bat/config` — identique · = work · via un lien stow
- [ ] `~/.config/direnv/direnv.sample.toml` — identique · = work · via un lien stow
- [ ] `~/.config/efm-langserver/config.yaml` — identique · = work · via un lien stow
- [ ] `~/.config/fd/ignore` — identique · = work · via un lien stow
- [ ] `~/.config/go/env` — identique · = work · via un lien stow
- [ ] `~/.config/kitty/` (7 fichiers identiques) · 7 = work · via un lien stow
- [ ] `~/.config/luaformatter/config.yaml` — identique · = work · via un lien stow
- [ ] `~/.config/nvim/` (192 fichiers identiques) · 192 = work · via un lien stow
- [ ] `~/.config/ripgrep/rc` — identique · = work · via un lien stow
- [ ] `~/.config/zsh/` (9 fichiers identiques) · 9 = work · via un lien stow
- [ ] `~/.gemrc` — identique · = work · via un lien stow
- [ ] `~/.local/share/bin/` (32 fichiers identiques) · 32 = work · via un lien stow

### 3.3 Absentes de `$HOME` et de `work`

18 cibles de `chezmoi` sont absentes de `$HOME`. Celles qui ne sont pas non plus dans `work` :

- [ ] `~/.config/sheldon/plugins.toml`
- [ ] `~/.config/zsh/plugins/alias.zsh`
- [ ] `~/.config/zsh/plugins/aliases/functions/update_claude`
- [ ] `~/ssh/config`

## 4. À ajouter à la branche `work`

### 4.1 Paquets de `~/.dotfiles` pas encore migrés

Chaque fichier suivi par git dans `~/.dotfiles` est cherché parmi les cibles de `work` et de `chezmoi`, y compris celles ignorées sur Ubuntu. Coché = couvert par un external ou un script.

- [ ] `bash` — 0/4 fichiers migrés, 4 à décider · non lié dans `$HOME`
  - [ ] `~/.bash_completion`
  - [ ] `~/.bash_profile`
  - [ ] `~/.bashrc`
  - [ ] `~/.profile`
- [x] `bat` — 1/5 fichiers migrés, 4 couverts par un external ou un script · lié dans `$HOME`
  - [x] `~/.config/bat/themes/catppuccin-*` (4 fichiers) — external
- [ ] `bin` — 33/39 fichiers migrés, 6 à décider · lié dans `$HOME`
  - [ ] `~/.local/share/bin/macos/` (6 fichiers) — macOS
- [x] `btop` — 1/8 fichiers migrés, 7 couverts par un external ou un script · non lié dans `$HOME`
  - [x] `~/.config/btop/themes/` (7 fichiers) — external
- [ ] `clifm` — 0/8 fichiers migrés, 8 à décider · non lié dans `$HOME`
  - [ ] `~/.config/clifm/keybindings.clifm`
  - [ ] `~/.config/clifm/prompts.clifm`
  - [ ] `~/.config/clifm/readline.clifm`
  - [ ] `~/.config/clifm/profiles/default/` (5 fichiers)
- [x] `fsh` — 0/4 fichiers migrés, 4 couverts par un external ou un script · non lié dans `$HOME`
  - [x] `~/.config/fsh/catppuccin-*` (4 fichiers) — external
- [ ] `fzf` — 0/29 fichiers migrés, 25 couverts par un external ou un script, 4 à décider · lié dans `$HOME`
  - [x] `~/.local/share/fzf/themes/rose-pine-dawn.sh` — external
  - [x] `~/.local/share/fzf/themes/rose-pine-moon.sh` — external
  - [x] `~/.local/share/fzf/themes/rose-pine.sh` — external
  - [x] `~/.local/share/fzf/themes/github*` (22 fichiers) — script `run_always_after_30-fzf-themes.sh`
  - [ ] `~/.local/share/fzf/themes/catppuccin-*` (4 fichiers)
- [ ] `git` — 2/5 fichiers migrés, 3 à décider · lié dans `$HOME`
  - [ ] `~/.local/share/git/linux-config`
  - [ ] `~/.local/share/git/local-config.sample`
  - [ ] `~/.local/share/git/macos-config` — macOS
- [ ] `kitty` — 8/42 fichiers migrés, 31 couverts par un external ou un script, 3 à décider · lié dans `$HOME`
  - [x] `~/.config/kitty/themes/` (31 fichiers) — external
  - [ ] `~/.config/kitty/.ignore`
  - [ ] `~/.config/kitty/kitty-linux.conf`
  - [ ] `~/.config/kitty/kitty-macos.conf` — macOS
- [ ] `lazygit` — 1/14 fichiers migrés, 4 couverts par un external ou un script, 9 à décider · lié dans `$HOME`
  - [x] `~/.local/share/lazygit/themes/catppuccin-*` (4 fichiers) — external
  - [ ] `~/.local/share/lazygit/themes/github_*` (9 fichiers)
- [ ] `niri` — 6/9 fichiers migrés, 3 à décider · non lié dans `$HOME`
  - [ ] `~/.config/niri/dms/cursor.kdl` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime
  - [ ] `~/.config/niri/dms/outputs.kdl` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime
  - [ ] `~/.config/niri/dms/windowrules.kdl` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime
- [ ] `nvim` — 210/212 fichiers migrés, 2 à décider · lié dans `$HOME`
  - [ ] `~/.config/nvim/Makefile`
  - [ ] `~/.config/nvim/lua/ppm/toolkit/color/init.lua` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime
- [ ] `ranger` — 0/4 fichiers migrés, 4 à décider · non lié dans `$HOME`
  - [ ] `~/.config/ranger/devicons.py`
  - [ ] `~/.config/ranger/rc.conf`
  - [ ] `~/.config/ranger/scope.sh`
  - [ ] `~/.config/ranger/plugins/devicons_linemode.py`
- [ ] `rofi` — 1/10 fichiers migrés, 9 à décider · non lié dans `$HOME`
  - [ ] `~/.local/share/rofi/themes/` (9 fichiers)
- [ ] `tmux` — 0/1 fichiers migrés, 1 à décider · non lié dans `$HOME`
  - [ ] `~/.config/tmux/tmux.conf`
- [ ] `yazi` — 5/31 fichiers migrés, 24 couverts par un external ou un script, 2 à décider · non lié dans `$HOME`
  - [x] `~/.config/yazi/` (24 fichiers) — plugins et flavors installés par le script yazi
  - [ ] `~/.config/yazi/flavors/catppuccin-latte.yazi/DO_NOT_MODIFY_ANYTHING_IN_THIS_DIRECTORY` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime
  - [ ] `~/.config/yazi/flavors/catppuccin-mocha.yazi/DO_NOT_MODIFY_ANYTHING_IN_THIS_DIRECTORY` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime
- [ ] `zsh` — 22/25 fichiers migrés, 3 à décider · lié dans `$HOME`
  - [ ] `~/.config/zsh/plugins/macos/init.zsh` — macOS
  - [ ] `~/.config/zsh/plugins/macos/path.zsh` — macOS
  - [ ] `~/.local/share/zsh/rc.sample.zsh` — vide : sans le préfixe `empty_`, `chezmoi apply` le supprime

Déjà entièrement migrés : `atuin`, `DankMaterialShell`, `direnv`, `eget`, `environment`, `fd`, `fontconfig`, `go`, `hledger`, `home`, `podman`, `ripgrep`, `starship`, `sway`, `terraform`, `zathura`.

Hors stow, à ne pas migrer : `include/` et `setup/` (Makefile et listes de paquets du bootstrap), `iterm/` (macOS).

### 4.2 Hors `~/.dotfiles`

Ces configurations existent dans `$HOME`, mais ni dans `~/.dotfiles` ni dans les deux branches.

- [ ] `~/.config/niri/noctalia.kdl`, `ws-layout.sh`, `air75-layout.sh` : fichiers du dépôt `~/.config/niri/` absents de `work` (point d'attention 3).
- [ ] `~/.config/doom/` (`config.el`, `init.el`, `packages.el`) : config Doom Emacs. `~/.config/emacs/` est le clone de Doom : à déclarer en external, pas à copier.
- [ ] `~/.config/act/actrc`
- [ ] `~/.config/gh/config.yml` : **jamais `hosts.yml`**, qui contient le jeton GitHub.
- [ ] `~/.config/herdr/config.toml` : le reste du dossier est de l'état (sessions, logs, sockets).
- [ ] `~/.config/hunk/config.toml` : pas `state.json`.
- [ ] `~/.config/rtk/config.toml` et `~/.config/rtk/filters.toml`
- [ ] `~/.config/npm/npmrc` : pas de jeton aujourd'hui. Passer en `private_` si un jeton y arrive.
- [ ] `~/.manpath` : une ligne, les pages `man` des paquets npm globaux.
- [ ] `~/.local/bin/vivaldi` : lanceur du snap Vivaldi.
- [ ] `~/.config/gtk-3.0/bookmarks` : signets de Nautilus (facultatif).
- [ ] `~/.config/mimeapps.list` : applications par défaut (facultatif).

À ne pas migrer :

- `~/.config/fzf/` (clone du dépôt fzf), `~/.config/emacs/` (clone de Doom), `~/.config/noctalia/` (vide).
- `~/.config/gtk-3.0/noctalia*.css` et `~/.config/qt6ct/colors/noctalia.conf` : générés par Noctalia.
- `~/.config/acli/` (authentification Atlassian), `~/.config/turborepo/` (télémétrie), `~/.config/systemd/` et `~/.config/autostart/` (créés par snap et par les applications).
- `~/.claude/` : `settings.json` et `egm/` pointent déjà vers `~/Private/Code/ai/claude`.
- `~/.bashrc` : squelette Ubuntu, plus une ligne `eval "$($ROOT_DIR/scripts/init.sh exec)"` ajoutée par un outil. `~/.profile` et `~/.bash_logout` sont le squelette, `~/.pam_environment` contient les locales GNOME. Le paquet `bash` de `~/.dotfiles` n'est pas lié (4.1).
- `~/.dotfiles/hackuity.*.asc` : clés GPG, dont une privée, non suivies par git. **Ne jamais les committer.**

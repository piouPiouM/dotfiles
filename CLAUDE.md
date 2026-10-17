# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), with [mise](https://mise.jdx.dev/) handling tool/language versions and (in-progress) task automation. The repo is mid-migration off an older GNU Make + Stow setup (see `README.md`, which still describes that old system and is stale in places — trust the actual source tree over it).

- `.chezmoiroot` points chezmoi's source root at `home/`. Everything chezmoi manages lives under `home/`, using chezmoi's naming convention (`dot_config` → `~/.config`, `private_*` → mode 0600, `run_once_*`/`run_onchange_*`/`run_always_*` → scripts, `.tmpl` → Go-template rendered).
- `mise.toml` at repo root only pins bootstrap tools (`age`, `tombi`). The real tool manifest is `home/dot_config/mise/config.toml.tmpl`, applied to `~/.config/mise/config.toml`.
- `docs/migrate-makefile-to-mise-tasks.md` is the design doc for porting the remaining imperative Make targets (Fedora provisioning, GNOME config, backups, neovim maintenance) to `mise/tasks/*` file tasks. Only `mise/tasks/install-proton-pass.sh` and `mise/tasks/clean-caches.sh` exist so far, each wired via an explicit `[tasks.<name>]` block in `home/dot_config/mise/config.toml.tmpl` (`file = "{{ dir .chezmoi.sourceDir }}/mise/tasks/<name>.sh"`; not yet auto-discovered) — check this doc before assuming a `setup:*`/`backup:*`/`install:*` task exists.
- `setup/**` holds package lists and dconf dumps (`packages-cli.txt`, `gnome-extensions.txt`, `*.dconf`, etc.) carried over from the old Makefile system. Nothing currently consumes them.

## Secrets

Full detail in `docs/secrets-management.md`. Summary:

- Secrets are encrypted with **age** and committed as `home/private_dot_private/private_chezmoi/encrypted_private_secrets.yaml.age`; the working copy chezmoi templates read is `home/.chezmoidata/secrets.yaml` (gitignored); the canonical editable copy is `~/.private/chezmoi/secrets.yaml`.
- `[hooks.read-source-state.pre]` in `home/.chezmoi.toml.tmpl` runs `home/.install-prerequisites.sh` before chezmoi reads any template. That script installs `age`/`pass-cli`/`mise` to `~/.local/bin`, authenticates Proton Pass CLI, and reconciles the three secrets copies by mtime — it only has `curl`/`wget` available (no `mise`, `gh`, etc. yet).
- SSH keys are pulled from Proton Pass at apply time by `home/.chezmoiscripts/run_once_before_10-deploy-ssk-keys.sh.tmpl` (`run_once`, so removing a key from `~/.ssh/` and re-running `chezmoi apply` is how you force redeployment).
- Never edit `home/.chezmoidata/secrets.yaml` directly when `~/.private/chezmoi/secrets.yaml` also exists — edit the latter; sync is timestamp-based.

## Machine identity

`home/.chezmoi.toml.tmpl` prompts once (cached) for `email`, `purpose` (`personal`/`work`), and (if `work`) `org`. These drive conditional `{{ if eq .purpose ... }}` / `{{ if eq .org ... }}` blocks across templates (e.g. extra mise tools, locale, ignored paths for non-`personal` purposes). When editing a `.tmpl` file, check for these conditionals rather than assuming a block applies to every machine.

## Common commands

- `chezmoi diff` — preview pending changes before applying.
- `chezmoi apply` — apply the source state to `$HOME`, running the prerequisites hook and any `run_*` scripts as needed.
- `chezmoi execute-template < path/to/file.tmpl` or `chezmoi cat ~/.config/<target>` — render a template to verify output without applying.
- `mise install` — install pinned tool versions from `~/.config/mise/config.toml` (rendered from `home/dot_config/mise/config.toml.tmpl`).
- `mise tasks ls` — list available mise file tasks (once `mise/tasks/` is wired into `[task_config] includes`, per the migration doc).

## Linting/formatting config (no build step)

This repo has no build or test suite — it's config files. Relevant tool configs at the root:

- `.editorconfig` — LF, no final newline by default; Lua files get a distinct style block for EmmyLuaCodeStyle.
- `.tombi.toml` — TOML formatter/linter config, applies to `**/*.toml` and `**/*.toml.tmpl`. Key/value alignment and indentation are enabled through an `[[overrides]]` block (excluding the mise config) because tombi can't reset a globally-`true` rule to `false` in an override.
- `.shellcheckrc` — `external-sources=true`, `source-path=SCRIPTDIR/bin`.
- `sgconfig.yml` — [ast-grep](https://ast-grep.github.io/) rules live in `.sg/rules`, tests in `.sg/rule-tests`, utils in `.sg/utils`.

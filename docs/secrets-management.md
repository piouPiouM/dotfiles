# Secrets Management

This document describes how secrets and SSH keys are managed in this dotfiles repository.

## Overview

The setup uses two complementary tools:

- **[age](https://age-encryption.org/)** — encrypts the `secrets.yaml` file so it can be committed to git safely.
- **[Proton Pass CLI](https://proton.me/pass/download)** (`pass-cli`) — provides runtime access to sensitive values (SSH private keys, API tokens) without ever writing them to disk in the repo.

Both tools are installed automatically by the prerequisites script before chezmoi reads any source state.

---

## Prerequisites

The hook `[hooks.read-source-state.pre]` in `.chezmoi.toml.tmpl` runs `.install-prerequisites.sh` before chezmoi processes any template. That script:

1. Installs `age`, `pass-cli`, and `mise` to `~/.local/bin` if not already present.
2. Authenticates `pass-cli` (opens a browser login if needed).
3. Syncs / decrypts `secrets.yaml` (see below).

The script requires only `curl` or `wget` — it runs before `mise` or any managed toolchain is available.

---

## Age keys

Two files must exist outside the repo before chezmoi can decrypt secrets:

| File | Purpose |
|------|---------|
| `~/.private/age/chezmoi.key.txt` | Private key — used to decrypt |
| `~/.private/age/chezmoi.recipient.txt` | Public key — used to encrypt |

### Generating a new key pair

```sh
mkdir -p ~/.private/age
age-keygen -o ~/.private/age/chezmoi.key.txt
# The public key is printed to stdout; save it:
age-keygen -y ~/.private/age/chezmoi.key.txt > ~/.private/age/chezmoi.recipient.txt
```

Keep both files out of version control. They are referenced in `.chezmoi.toml.tmpl` as the age identity/recipient.

---

## secrets.yaml

### File locations

| Path | Description |
|------|-------------|
| `~/.private/chezmoi/secrets.yaml` | Canonical plain-text copy (never committed) |
| `home/.chezmoidata/secrets.yaml` | Working copy read by chezmoi templates (gitignored) |
| `home/private_dot_private/private_chezmoi/encrypted_private_secrets.yaml.age` | Age-encrypted copy committed to git |

### Sync logic (run by the prerequisites script)

The script resolves which copy is authoritative and keeps all three in sync:

| Situation | Action |
|-----------|--------|
| Fresh clone (neither plain-text copy exists) | Decrypt `.age` file → `~/.private/chezmoi/secrets.yaml` → copy to `.chezmoidata/secrets.yaml` |
| Only `.chezmoidata/secrets.yaml` exists | Copy to `~/.private/`, then re-encrypt |
| Only `~/.private/chezmoi/secrets.yaml` exists | Copy to `.chezmoidata/`, then re-encrypt |
| Both exist, identical | Skip copy; re-encrypt only if `.age` file is stale |
| Both exist, `.chezmoidata/` is newer | Sync `.chezmoidata/` → `~/.private/`, then re-encrypt |
| Both exist, `~/.private/` is newer | Sync `~/.private/` → `.chezmoidata/`, then re-encrypt |

### Schema

```yaml
secrets:
  proton:
    prefix: "pass://<vault-id>/"   # Base path for all Proton Pass items
    age:
      recipient: "<item-path>/Public key"  # Proton Pass item holding the age public key
    github_tokens:
      mise: "<item-path>/API Key"          # GitHub token for mise tool installations
    ssh:
      # Keyed by machine purpose ("personal" or the org name for work machines).
      personal:
        config:
          - "<item-id>"   # Proton Pass item IDs for SSH config file fragments
        keys:
          - "<item-id>"   # Proton Pass item IDs for SSH key pairs
```

### Editing secrets

Edit `~/.private/chezmoi/secrets.yaml` directly. The next `chezmoi apply` (or any command that triggers the prerequisite hook) will sync the change to `.chezmoidata/secrets.yaml` and re-encrypt the `.age` file automatically.

Do **not** edit `home/.chezmoidata/secrets.yaml` directly when both plain-text copies exist — timestamp-based sync may overwrite your changes.

---

## SSH keys

SSH keys are stored as items in Proton Pass and deployed by the script `run_once_before_10-deploy-ssk-keys.sh.tmpl`.

### Proton Pass item structure

Each SSH key pair is stored as a Proton Pass item under the path:

```
<secrets.proton.prefix><item-id>/
  Filename       → the filename used under ~/.ssh/ (e.g. id_ed25519_github)
  Private key    → raw private key content
  Public key     → raw public key content
```

### Deployment

The script iterates over `secrets.proton.ssh` entries whose key matches the current machine's `purpose` (or `org` for work machines). For each key item it:

1. Reads the filename from `<item>/Filename` via `pass-cli item view`.
2. Writes the private key to `~/.ssh/<filename>` with `umask 077` if it does not already exist.
3. Writes the public key to `~/.ssh/<filename>.pub` with mode `600` if it does not already exist.

The script is `run_once` — it only runs on a fresh apply. To force re-deployment, remove the key files from `~/.ssh/` and re-run `chezmoi apply`.

### Adding a new SSH key

1. Create a new item in Proton Pass with the structure above.
2. Add the item ID to the `keys` list under the appropriate purpose in `~/.private/chezmoi/secrets.yaml`.
3. Run `chezmoi apply` — the prerequisites script will sync and re-encrypt `secrets.yaml`.

---

## Proton Pass CLI authentication

`pass-cli` authenticates once per machine via a browser-based login. The prerequisites script calls `pass-cli test` to check the session and runs `pass-cli login` if needed. Re-authentication is required if the session expires or the binary is reinstalled.

To manually re-authenticate:

```sh
pass-cli login
```

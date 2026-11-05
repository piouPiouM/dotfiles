# environment.d

Files in `~/.config/environment.d/` set the environment of the systemd user manager,
which GDM passes on to the graphical session (niri, noctalia, apps they spawn).
Shell rc files are never read there, so tools outside the system dirs (mise shims, brew, fzf)
need their directories added here.

## FAQ

### Why is the PATH file named `991-path.conf`?

systemd reads `/usr/lib/environment.d/`, `/etc/environment.d/` and `~/.config/environment.d/`
as one list sorted by **filename**, regardless of directory. On this system:

| File                                      | Effect on `PATH`                                   |
| ----------------------------------------- | -------------------------------------------------- |
| `/etc/environment.d/99-environment.conf`  | Link to `/etc/environment`: **resets** `PATH`      |
| `/etc/environment.d/990-snapd.conf`       | Appends `/snap/bin`                                |
| `~/.config/environment.d/991-path.conf`   | Prepends mise shims, appends brew and fzf bins     |

Any name sorting before `99-environment.conf` (e.g. `50-path.conf`) is silently overwritten.
`991-` sorts after every system file, so the shims survive.

### How do I check the resulting `PATH` without logging out?

```sh
env -i HOME=$HOME PATH=/usr/bin:/bin \
  /usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator | grep ^PATH=
```

The first entry must be `~/.local/share/mise/shims`. The change only reaches the session at the next login.

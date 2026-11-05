# Prompt: wl-screenrec on Fedora (purpose = "personal")

Usage, on the Fedora laptop, from the chezmoi source dir (`chezmoi source-path`, then `..`):
`claude "Follow docs/wl-screenrec-fedora.md"`

---

Add the Fedora part of the wl-screenrec install to my chezmoi dotfiles, then install it on this
machine. wl-screenrec (https://github.com/rosalyntg/wl-screenrec) records the screen through
VA-API on niri. This laptop runs Fedora, chezmoi `purpose = "personal"`, Intel GPU.

## What already exists (Ubuntu, purpose = "hackuity")

- `home/.chezmoiscripts/run_onchange_before_05-wl-screenrec-deps.sh.tmpl`: installs the system
  packages with apt. Its whole body sits in `{{ if eq .purpose "hackuity" -}} … {{ end -}}`:
  for any other purpose it renders empty and chezmoi skips it.
- `home/dot_config/mise/config.toml.tmpl`: `"cargo:wl-screenrec" = "latest"` under `[tools]`,
  gated on `purpose == "hackuity"`. mise builds it from source (no release binaries upstream).
- `run_onchange_after_10-mise-install.sh.tmpl` hashes the mise config and runs `mise install`.
  The deps script is `before_` so the libs exist before that build.

## Steps

1. Check the machine first, don't assume: Fedora version, `dnf repolist` (RPM Fusion enabled?),
   `rpm -q ffmpeg ffmpeg-free ffmpeg-libs libavcodec-free`, `lspci -nn | grep -Ei 'vga|3d'`,
   `vainfo` (from `libva-utils`; look for `iHD` and `VAEntrypointEncSlice` on H264/HEVC).
2. Show me the findings and **ask me** which ffmpeg to use before writing anything:
   - **RPM Fusion** (upstream says it is needed for hardware encode): enable free + nonfree,
     `dnf swap ffmpeg-free ffmpeg --allowerasing`, then `ffmpeg-devel` + `intel-media-driver`.
     Check the commands against https://rpmfusion.org/Howto/Multimedia.
   - **Fedora repos only**: upstream's list `ffmpeg-free-devel libdrm-devel freeglut-devel clang`
     + `libva-intel-media-driver`. H.264/HEVC VA-API encode may be missing.
   - The two conflict: `ffmpeg-free-devel` can't be installed next to RPM Fusion's `ffmpeg`.
3. Add a `{{ if eq .purpose "personal" }}` branch to the deps script with `sudo dnf install -y …`.
   The shebang must stay the first line of the rendered output for both purposes. Keep the
   apt branch unchanged.
4. In the mise config, also enable `"cargo:wl-screenrec"` for `personal`.
5. Verify before installing:
   - Render both purposes with a throwaway config (the mise template also needs
     `directories.cargoHome`):
     `printf '[data]\n  purpose = "personal"\n[data.directories]\n  cargoHome = "x"\n' > /tmp/cz.toml`
     then `chezmoi --config /tmp/cz.toml --source home execute-template < <file>`.
     `hackuity` must render the apt branch, `personal` the dnf branch.
   - `shellcheck` the rendered script, `tombi lint` the rendered mise config.

Then give me the `sudo dnf …` line to run myself, and only after that: build with
`mise install` (or `chezmoi apply` if I say so), and check:

- `wl-screenrec --version`
- `timeout 5 wl-screenrec -f /tmp/t.mp4; ffprobe /tmp/t.mp4`

## Known gotchas

- bindgen `couldn't find libclang` → add `clang-devel`.
- `ffmpeg-sys-next` fails on pkg-config → a `*-devel` package is missing; read which `.pc` file.
- Recording fails on VA-API init → pass `--dri-device /dev/dri/renderD128`, after checking with
  `ls -l /dev/dri/by-path` that it is the Intel node.

## Rules

- Don't run `sudo`, `chezmoi apply` or `dnf` changes yourself without asking me.
- Don't commit unless I ask.

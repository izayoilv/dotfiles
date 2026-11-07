# dotfiles

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-Zsh%20%2B%20Sheldon-f1a2ae.svg)](https://www.zsh.org/)
[![Prompt](https://img.shields.io/badge/prompt-Starship-dd.svg)](https://starship.rs/)
[![Terminal](https://img.shields.io/badge/terminal-Ghostty-purple.svg)](https://ghostty.org)
[![Editor](https://img.shields.io/badge/editor-Neovim-57a639.svg)](https://neovim.io)
[![Colorscheme](https://img.shields.io/badge/colorscheme-Kanagawa--Wave-purple.svg)](https://github.com/rebelot/kanagawa.nvim)

My personal dotfiles, managed as a git repo with a symlink-based install script.

## Structure

```
dotfiles/
├── home/                    # Files symlinked to $HOME
│   ├── .gitconfig
│   ├── .zshenv
│   ├── .profile
│   ├── .bash_profile
│   ├── .bashrc
│   ├── .npmrc
│   └── .commitlintrc.json
├── config/                  # Directories symlinked to ~/.config/
│   ├── nvim/                # Neovim — see README inside
│   ├── zsh/                 # Zsh configuration
│   ├── proto/               # Global Proto toolchain baseline
│   ├── uv/                  # uv Python preference
│   ├── bun/                 # Global Bun CLI manifest + trust list
│   ├── gradle/              # Shared Gradle user properties
│   ├── opencode/            # OpenCode global config
│   ├── sheldon/             # Sheldon (zsh plugin manager)
│   ├── starship/            # Starship prompt
│   ├── fastfetch/           # System info
│   └── ghostty/             # Ghostty terminal
├── packages/                # Bun global CLI inventory
├── scripts/                 # Host maintenance scripts
│   ├── maintenance-atomic   # Fedora Atomic (rpm-ostree)
│   └── maintenance-workstation
├── Brewfile                 # Homebrew bundle (install-brew.sh)
├── install-dotnet.sh        # .NET SDK + csharp-ls (official script, user-space)
├── install-fonts.sh         # JetBrainsMono Nerd Font installer
├── install-plenv.sh         # plenv (Perl) + Neovim::Ext installer
├── install-uv-python.sh     # uv-managed Python + pynvim venv for nvim
├── install.sh               # Symlink installer
├── install-maintenance.sh   # Installs the matching maintenance script
├── install-packages.sh      # Bun global CLI installer
├── install-proto.sh         # Proto toolchain installer
├── install-tinytex.sh       # TinyTeX (TeX Live 2026) installer
├── .pre-commit-config.yaml  # Pre-commit hooks (lint, format, secrets)
├── .gitignore
└── LICENSE
```

## Configs

| Config        | Description                                                                                                                                                                                                          |
| ------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **nvim**      | [Lazy.nvim](https://github.com/folke/lazy.nvim) + [Snacks.nvim](https://github.com/folke/snacks.nvim) + Kanagawa. See [config/nvim/README.md](config/nvim/README.md) for plugins, keybindings, and language servers. |
| **zsh**       | Vi-mode, autosuggestions, history substring search, fzf, aliases                                                                                                                                                     |
| **proto**     | Global toolchain baseline and security settings                                                                                                                                                                      |
| **uv**        | Managed-Python preference                                                                                                                                                                                            |
| **bun**       | Global CLI manifest, trust list, and compatibility overrides                                                                                                                                                         |
| **gradle**    | Shared `~/.gradle/gradle.properties`; the JDK is resolved from Proto                                                                                                                                                 |
| **opencode**  | Global config, agents, commands, skills, instructions                                                                                                                                                                |
| **sheldon**   | Lightweight zsh plugin manager configuration                                                                                                                                                                         |
| **starship**  | Cross-shell prompt with Kanagawa colors                                                                                                                                                                              |
| **fastfetch** | System info display                                                                                                                                                                                                  |
| **ghostty**   | Fast terminal emulator                                                                                                                                                                                               |

### Home dotfiles

| File                 | Description                                       |
| -------------------- | ------------------------------------------------- |
| `.gitconfig`         | Delta, difftastic, absorb, custom aliases         |
| `.zshenv`            | Sets `ZDOTDIR`, Proto/Cargo/JDK/npm/pnpm/Bun PATH |
| `.profile`           | Shared login-shell PATH and Java environment      |
| `.bash_profile`      | Sources the shared profile and bashrc             |
| `.bashrc`            | Bash interactive config mirroring the zsh setup   |
| `.npmrc`             | pnpm `allow-scripts` allowlist                    |
| `.commitlintrc.json` | Conventional commits enforcement                  |

## Requirements

- Linux (Fedora tested)
- Zsh 5.0+ and Bash 4.0+
- Git 2.20+
- curl, tar, xz, sha256sum, and perl (Proto, rustup, and TinyTeX bootstrap)
- Neovim 0.12+ (for nvim config)

## Global packages

Global CLI tools are installed with Bun. Versions are intentionally `latest`; the trust list lives in `config/bun/package.json`. The human-readable inventory is `packages/bun-global.txt`.

Run `./install.sh` and `./install-proto.sh` first, then restore the packages with:

```sh
./install-packages.sh
./install-brew.sh
```

`install-packages.sh` restores Bun global CLIs from `packages/bun-global.txt`
(manifest in `config/bun/package.json`);
`install-brew.sh` runs `brew bundle` against the root `Brewfile`.
npm and pnpm remain available for projects, and their global bin paths stay on `PATH`; they do not own global CLIs.

Note: `@moonshot-ai/kimi-code` requires `libatomic` on Fedora. Layer it with
`sudo rpm-ostree install libatomic`.

## Maintenance

`install-maintenance.sh` detects Fedora Atomic via `/run/ostree-booted` and installs the matching script as a root-owned `/usr/local/bin/maintenance`. On Atomic, `/usr/local` is `/var/usrlocal`, so it survives upgrades. Run it with:

```sh
sudo maintenance
```

The scripts reflect the host model: Workstation uses `dnf`, snap, and Flatpak; Atomic uses `rpm-ostree` and Flatpak. The sudoers `NOPASSWD` rule is optional; without it, sudo prompts for your password.

## Proto toolchains

`install-proto.sh` verifies and installs a pinned Proto release, then installs the global baseline from `config/proto/.prototools`. Project `.prototools` and committed `.protolock` files take precedence.

The global config disables telemetry, community plugins, auto-install/clean, builtin backends, and system package installs. Global config cannot use `.protolock`, so refresh the baseline deliberately:

```sh
proto install --config-mode global -y
```

Proto provides Node, npm, pnpm, Bun, Go, Ruby, uv, Java (Temurin 21), and Kotlin. Rust is delegated to rustup; uv remains the Python manager. `config/uv/uv.toml` restricts uv to managed Python installations, so run `uv python install 3.14` once per machine (the Proto installer does this). Node uses the `stable` alias; the other global tools use `latest`.

Gradle is not installed globally; use `./gradlew` in projects. The shell uses Proto shims and resolves `JAVA_HOME` from the active JDK. nvm and SDKMAN are not used.

## Language runtimes (optional)

- .NET 9: `./install-dotnet.sh` (official script, user-space). .NET 9 on
  Fedora 45 needs OpenSSL 3: `sudo rpm-ostree install openssl3-libs`.
- C# LSPs: `omnisharp` (Mason, for Unity) + `csharp-ls` 0.20.0 (dotnet
  tool, for general .NET; newer versions have a broken NuGet package).
- LLVM/Clang: `brew install llvm` provides `clang` + `clang-format` for C/C++
  LSP formatting. `luarocks` provides the `jsregexp` LuaSnip transform (build
  manually from `~/.local/share/nvim/lazy/LuaSnip/deps/jsregexp` if desired).
- Perl: `./install-plenv.sh` (plenv + Neovim::Ext). Defaults to system Perl
  (latest stable); pass `--build` to compile a separate version.
- Python: `./install-uv-python.sh` (uv-managed venv + pynvim for nvim).

## LaTeX

`install-tinytex.sh` installs TinyTeX v2026.10 (TeX Live 2026) into `~/.TinyTeX` and the LuaLaTeX, biblatex-apa, biber, and latexmk packages used by the paper and resume. Build documents with `latexmk` as usual.

TinyTeX is self-contained; Fedora TeX Live and system Ruby are not required. Fedora needs `libxcrypt-compat` for TinyTeX's biber:

```sh
sudo dnf install libxcrypt-compat
```

> **Quirk (TeX Live 2026):** `tlmgr`'s post-install hook invokes `fmtutil` with
> combined `--byfmt`/`--byhyphen` flags that newer `fmtutil` rejects, so the
> format rebuild fails. After install, rebuild manually:
> `~/.TinyTeX/bin/x86_64-linux/fmtutil-sys --byfmt lualatex` (or `--all`).

Manage packages with:

```sh
~/.TinyTeX/bin/x86_64-linux/tlmgr install <package>
```

## Desktop (COSMIC)

- COSMIC desktop theme: a community Kanagawa theme is available at
  https://cosmic-themes.org/103/ — download the `.ron` file and import it via
  COSMIC Settings → Desktop → Appearance → Import. Ghostty, Neovim, and
  Starship already use Kanagawa Wave.
- Media codecs (Fedora Atomic): enable RPM Fusion (free+nonfree), then swap
  the base ffmpeg for the full build via a coupled override:
  `sudo rpm-ostree override remove fdk-aac-free libavcodec-free libavdevice-free
  libavfilter-free libavformat-free libavutil-free libswresample-free
  libswscale-free ffmpeg-free --install ffmpeg`. Then layer
  `gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly intel-media-driver
  libva-utils`. Firefox uses `ffmpeg`; VA-API via `intel-media-driver`.

## OpenCode

`config/opencode/` holds the repo-managed config: `opencode.json`, `cli.json`, `agents/`, `commands/`, `skills/`, and `instructions/`. Runtime data stays local in `~/.config/opencode/` and is not tracked: `service.json`, `memory/`, `specs/`, `plans/`, and `projects/`.

`cli.json` is copied rather than linked because the terminal client rewrites it; re-copy it after changing TUI settings.

## Installation

```sh
git clone https://github.com/izayoilv/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
sudo ./install-maintenance.sh
./install-proto.sh
./install-tinytex.sh
./install-packages.sh
./install-brew.sh
./install-fonts.sh
./install-plenv.sh
./install-uv-python.sh
./install-dotnet.sh
```

The `install.sh` script creates symlinks from `~/.config/` and `$HOME` to the repo. Re-run after updates.

## License

[MIT](LICENSE) © 2026 IzayoiLv

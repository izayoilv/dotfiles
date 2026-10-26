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
│   ├── opencode/            # OpenCode global config
│   ├── sheldon/             # Sheldon (zsh plugin manager)
│   ├── starship/            # Starship prompt
│   ├── fastfetch/           # System info
│   └── ghostty/             # Ghostty terminal
├── packages/                # Pinned global npm/pnpm inventories
├── install.sh               # Symlink installer
├── install-packages.sh      # Global package installer
├── install-proto.sh         # Proto toolchain installer
├── .pre-commit-config.yaml  # Pre-commit hooks (lint, format, secrets)
├── .gitignore
└── LICENSE
```

## Configs

| Config | Description |
|---|---|
| **nvim** | [Lazy.nvim](https://github.com/folke/lazy.nvim) + [Snacks.nvim](https://github.com/folke/snacks.nvim) + Kanagawa. See [config/nvim/README.md](config/nvim/README.md) for plugins, keybindings, and language servers. |
| **zsh** | Vi-mode, autosuggestions, history substring search, fzf, aliases |
| **opencode** | Global config, agents, commands, skills, instructions |
| **sheldon** | Lightweight zsh plugin manager configuration |
| **starship** | Cross-shell prompt with Kanagawa colors |
| **fastfetch** | System info display |
| **ghostty** | Fast terminal emulator |

### Home dotfiles

| File | Description |
|---|---|
| `.gitconfig` | Delta, difftastic, absorb, custom aliases |
| `.zshenv` | Points `ZDOTDIR` to `~/.config/zsh/` and sets the Proto/Cargo/npm/pnpm PATH |
| `.profile` | Shared toolchain PATH and npm/pnpm/uv environment for login shells |
| `.bash_profile` | Sources the shared profile and bashrc |
| `.bashrc` | Bash interactive config mirroring the zsh setup |
| `.npmrc` | pnpm `allow-scripts` allowlist |
| `.commitlintrc.json` | Conventional commits enforcement |

## Requirements

- Linux (Fedora tested)
- Zsh 5.0+ and Bash 4.0+
- Git 2.20+
- curl, tar, xz, and sha256sum (Proto and rustup bootstrap)
- Neovim 0.12+ (for nvim config)

## Global packages

Pinned inventories of the globally installed CLI tools:

- `packages/npm-global.txt` — npm globals in `~/.local/share/npm`
- `packages/pnpm-global.txt` — pnpm globals in `~/.local/share/pnpm`

Node, npm, and pnpm are provided by Proto, not by the OS. Run `./install.sh` and `./install-proto.sh` first, then restore the packages with:

```sh
./install-packages.sh
```

## Proto toolchains

`install-proto.sh` verifies and installs a pinned Proto release, then installs the global baseline from `config/proto/.prototools`. Global pins use `latest`; project `.prototools` and committed `.protolock` files take precedence.

The global config disables telemetry, community plugins, auto-install/clean, builtin backends, and system package installs. Global config cannot use `.protolock`, so refresh the baseline deliberately:

```sh
proto install --config-mode global -y
```

Rust is delegated to rustup, and uv remains the Python manager. `config/uv/uv.toml` restricts uv to managed Python installations, so run `uv python install 3.14` once per machine (the Proto installer does this).

nvm is retired: both shells resolve Node, npm, and pnpm through Proto shims. System Go, uv, cargo, and rust packages can be removed because Proto/rustup shims take precedence. System Ruby stays because Fedora's texlive packages depend on it.

## OpenCode

`config/opencode/` holds the repo-managed config: `opencode.json`, `cli.json`, `agents/`, `commands/`, `skills/`, and `instructions/`. Runtime data stays local in `~/.config/opencode/` and is not tracked: `service.json`, `memory/`, `specs/`, `plans/`, and `projects/`.

`cli.json` is copied rather than linked because the terminal client rewrites it; re-copy it after changing TUI settings.

## Installation

```sh
git clone https://github.com/izayoilv/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
./install-proto.sh
./install-packages.sh
```

The `install.sh` script creates symlinks from `~/.config/` and `$HOME` to the repo. Re-run after updates.

## License

[MIT](LICENSE) © 2026 IzayoiLv

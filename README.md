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
│   ├── .npmrc
│   └── .commitlintrc.json
├── config/                  # Directories symlinked to ~/.config/
│   ├── nvim/                # Neovim — see README inside
│   ├── zsh/                 # Zsh configuration
│   ├── sheldon/             # Sheldon (zsh plugin manager)
│   ├── starship/            # Starship prompt
│   ├── fastfetch/           # System info
│   └── ghostty/             # Ghostty terminal
├── packages/                # Pinned global npm/pnpm inventories
├── install.sh               # Symlink installer
├── install-packages.sh      # Global package installer
├── .pre-commit-config.yaml  # Pre-commit hooks (lint, format, secrets)
├── .gitignore
└── LICENSE
```

## Configs

| Config | Description |
|---|---|
| **nvim** | [Lazy.nvim](https://github.com/folke/lazy.nvim) + [Snacks.nvim](https://github.com/folke/snacks.nvim) + Kanagawa. See [config/nvim/README.md](config/nvim/README.md) for plugins, keybindings, and language servers. |
| **zsh** | Vi-mode, autosuggestions, history substring search, fzf, aliases |
| **sheldon** | Lightweight zsh plugin manager configuration |
| **starship** | Cross-shell prompt with Kanagawa colors |
| **fastfetch** | System info display |
| **ghostty** | Fast terminal emulator |

### Home dotfiles

| File | Description |
|---|---|
| `.gitconfig` | Delta, difftastic, absorb, custom aliases |
| `.zshenv` | Points `ZDOTDIR` to `~/.config/zsh/` |
| `.profile` | Sources cargo env and envman load script |
| `.npmrc` | pnpm `allow-scripts` allowlist |
| `.commitlintrc.json` | Conventional commits enforcement |

## Requirements

- Linux (Fedora tested)
- Zsh 5.0+
- Git 2.20+
- Node.js 24+ and pnpm 12+ (for global package restoration)
- Neovim 0.12+ (for nvim config)

## Global packages

Pinned inventories of the globally installed CLI tools:

- `packages/npm-global.txt` — npm globals
- `packages/pnpm-global.txt` — pnpm globals

Run `./install.sh` first so `~/.npmrc` is linked, then restore the packages with:

```sh
./install-packages.sh
```

Node, npm, and pnpm themselves are prerequisites and are not listed.

## Installation

```sh
git clone https://github.com/izayoilv/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The `install.sh` script creates symlinks from `~/.config/` and `$HOME` to the repo. Re-run after updates.

## License

[MIT](LICENSE) © 2026 IzayoiLv

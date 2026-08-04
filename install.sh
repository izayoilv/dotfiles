#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
    local source="$1"
    local dest="$2"
    rm -rf "$dest"
    ln -sfn "$source" "$dest"
}

link "$DOTFILES_DIR/home/.gitconfig"        "$HOME/.gitconfig"
link "$DOTFILES_DIR/home/.zshenv"           "$HOME/.zshenv"
link "$DOTFILES_DIR/home/.profile"          "$HOME/.profile"
link "$DOTFILES_DIR/home/.npmrc"            "$HOME/.npmrc"
link "$DOTFILES_DIR/home/.commitlintrc.json" "$HOME/.commitlintrc.json"

link "$DOTFILES_DIR/config/nvim"       "$HOME/.config/nvim"
link "$DOTFILES_DIR/config/zsh"        "$HOME/.config/zsh"
link "$DOTFILES_DIR/config/starship"   "$HOME/.config/starship"
link "$DOTFILES_DIR/config/sheldon"    "$HOME/.config/sheldon"
link "$DOTFILES_DIR/config/fastfetch"  "$HOME/.config/fastfetch"
link "$DOTFILES_DIR/config/ghostty"    "$HOME/.config/ghostty"

echo "Dotfiles installed successfully."

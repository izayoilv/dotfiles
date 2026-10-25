#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
    local source="$1"
    local dest="$2"
    rm -rf "$dest"
    ln -sfn "$source" "$dest"
}

copy() {
    local source="$1"
    local dest="$2"
    rm -f "$dest"
    cp -p "$source" "$dest"
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

mkdir -p "$HOME/.config/opencode"
link "$DOTFILES_DIR/config/opencode/opencode.json"   "$HOME/.config/opencode/opencode.json"
copy "$DOTFILES_DIR/config/opencode/cli.json"        "$HOME/.config/opencode/cli.json"
link "$DOTFILES_DIR/config/opencode/agents"          "$HOME/.config/opencode/agents"
link "$DOTFILES_DIR/config/opencode/commands"        "$HOME/.config/opencode/commands"
link "$DOTFILES_DIR/config/opencode/skills"          "$HOME/.config/opencode/skills"
link "$DOTFILES_DIR/config/opencode/instructions"    "$HOME/.config/opencode/instructions"

echo "Dotfiles installed successfully."

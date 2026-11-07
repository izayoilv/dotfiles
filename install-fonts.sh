#!/usr/bin/env bash
set -euo pipefail

# Installs JetBrainsMono Nerd Font (latest) into ~/.local/share/fonts.
# Required by ghostty/starship/fastfetch/neovim glyph configs.

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
ARCHIVE_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"

mkdir -p "$FONT_DIR"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

echo "Downloading latest JetBrainsMono Nerd Font..."
curl -fsSL "$ARCHIVE_URL" -o "$tmpdir/JetBrainsMono.tar.xz"

echo "Extracting..."
tar -xf "$tmpdir/JetBrainsMono.tar.xz" -C "$FONT_DIR"

echo "Rebuilding font cache..."
fc-cache -fv >/dev/null

echo "Installed. Verify with: fc-list | grep -i 'JetBrainsMono Nerd'"
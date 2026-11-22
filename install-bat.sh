#!/usr/bin/env bash
set -euo pipefail

# Installs the official Kanagawa tmTheme for bat and rebuilds its theme cache.
# Kanagawa is the palette used by Ghostty, Neovim, Starship, and Delta.

# "master" tracks upstream; set KANAGAWA_REF to a tag or commit to pin.
KANAGAWA_REF="${KANAGAWA_REF:-master}"
THEME_URL="https://raw.githubusercontent.com/rebelot/kanagawa.nvim/${KANAGAWA_REF}/extras/tmTheme/kanagawa.tmTheme"
BAT_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bat"
THEME_DIR="$BAT_CONFIG_DIR/themes"
THEME_FILE="$THEME_DIR/kanagawa.tmTheme"

die() {
    echo "error: $*" >&2
    exit 1
}

command -v curl >/dev/null 2>&1 || die "curl is required"
command -v bat >/dev/null 2>&1 || die "bat is required; run ./install-brew.sh first"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

echo "Downloading Kanagawa tmTheme..."
curl --proto '=https' --tlsv1.2 -fsSL "$THEME_URL" -o "$tmp"
if ! grep -q '<plist' "$tmp" || ! grep -qi 'kanagawa' "$tmp"; then
    die "downloaded file does not look like the Kanagawa tmTheme"
fi

mkdir -p "$THEME_DIR"
install -m 0644 "$tmp" "$THEME_FILE"

echo "Rebuilding bat theme cache..."
bat cache --build >/dev/null

echo "Installed $THEME_FILE"

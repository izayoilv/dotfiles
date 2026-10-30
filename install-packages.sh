#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$DOTFILES_DIR/config/bun/package.json"
PACKAGES="$DOTFILES_DIR/packages/bun-global.txt"
GLOBAL_DIR="${BUN_INSTALL_GLOBAL_DIR:-$HOME/.bun/install/global}"

require() {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 is required" >&2; exit 1; }
}

require bun

mkdir -p "$GLOBAL_DIR"
cp "$MANIFEST" "$GLOBAL_DIR/package.json"

packages=()
while IFS= read -r pkg; do
    case "$pkg" in
        ''|'#'*) continue ;;
    esac
    packages+=("$pkg")
done < "$PACKAGES"

[ "${#packages[@]}" -gt 0 ] || { echo "no global packages configured" >&2; exit 1; }

bun add -g "${packages[@]}"
bun pm ls -g

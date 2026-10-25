#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES_DIR="$DOTFILES_DIR/packages"

require() {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 is required" >&2; exit 1; }
}

install_npm() {
    while IFS= read -r pkg; do
        case "$pkg" in
            ''|'#'*) continue ;;
        esac
        npm install -g "$pkg"
    done < "$PACKAGES_DIR/npm-global.txt"
}

install_pnpm() {
    while IFS= read -r pkg; do
        case "$pkg" in
            ''|'#'*) continue ;;
        esac
        pnpm add -g "$pkg"
    done < "$PACKAGES_DIR/pnpm-global.txt"
}

require npm
require pnpm
install_npm
install_pnpm

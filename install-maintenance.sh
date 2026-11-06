#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$(id -u)" -ne 0 ]; then
    exec sudo -- "$DOTFILES_DIR/install-maintenance.sh" "$@"
fi

if [ -e /run/ostree-booted ] || command -v rpm-ostree >/dev/null 2>&1; then
    platform="Fedora Atomic"
    source="$DOTFILES_DIR/scripts/maintenance-atomic"
else
    platform="Fedora Workstation"
    source="$DOTFILES_DIR/scripts/maintenance-workstation"
fi

if [ ! -f "$source" ]; then
    echo "Missing $source" >&2
    exit 1
fi

install -d -o root -g root -m 0755 /usr/local/bin
install -o root -g root -m 0755 "$source" /usr/local/bin/maintenance

if command -v restorecon >/dev/null 2>&1; then
    restorecon -F /usr/local/bin/maintenance || true
fi

echo "Installed $platform maintenance script to /usr/local/bin/maintenance"
echo "Run: sudo maintenance"

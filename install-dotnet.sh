#!/usr/bin/env bash
set -euo pipefail

# Installs the .NET SDK via the official dotnet-install.sh (user-space, no root).
# Usage: ./install-dotnet.sh [channel]   (default: 9.0)
# For multiple SDKs, run again with a different channel/version.

CHANNEL="${1:-9.0}"
INSTALL_DIR="${DOTNET_ROOT:-$HOME/.dotnet}"

mkdir -p "$INSTALL_DIR"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

echo "Downloading dotnet-install.sh..."
curl -fsSL https://dot.net/v1/dotnet-install.sh -o "$tmpdir/dotnet-install.sh"
chmod +x "$tmpdir/dotnet-install.sh"

echo "Installing .NET SDK (channel $CHANNEL) into $INSTALL_DIR..."
"$tmpdir/dotnet-install.sh" --channel "$CHANNEL" --install-dir "$INSTALL_DIR"

echo "Installed: $("$INSTALL_DIR/dotnet" --version)"

# Install csharp-ls (C# LSP for general .NET dev) pinned to 0.20.0.
# Newer versions (0.24.0+) have a broken NuGet package (missing
# DotnetToolSettings.xml); revisit when upstream fixes it.
echo "Installing csharp-ls 0.20.0..."
"$INSTALL_DIR/dotnet" tool install -g csharp-ls --version 0.20.0 2>&1 | tail -3 || true
echo "csharp-ls: $(command -v csharp-ls || echo 'not on PATH (source your shell)')"

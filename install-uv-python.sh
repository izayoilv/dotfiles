#!/usr/bin/env bash
set -euo pipefail

# Installs a uv-managed Python and creates an isolated venv for Neovim's
# Python provider (pynvim). Uses uv (already installed by install-proto.sh).
# Usage: ./install-uv-python.sh [python-version]   (default: latest stable)

PY_VERSION="${1:-}"
VENV_DIR="${NVIM_PYTHON_VENV:-$HOME/.local/share/nvim/python}"

require() {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 is required (run install-proto.sh first)" >&2; exit 1; }
}
require uv

if [ -n "$PY_VERSION" ]; then
    echo "Ensuring uv-managed Python $PY_VERSION..."
    uv python install "$PY_VERSION"
else
    echo "Ensuring latest uv-managed Python..."
    uv python install
fi

UV_PYTHON="$(uv python find)"
echo "Using Python: $UV_PYTHON"

echo "Creating nvim provider venv at $VENV_DIR..."
uv venv --python "$UV_PYTHON" "$VENV_DIR" --clear

echo "Installing pynvim..."
uv pip install --python "$VENV_DIR" pynvim

echo "Done. nvim python3 provider: $VENV_DIR/bin/python"

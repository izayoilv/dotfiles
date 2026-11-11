#!/usr/bin/env bash
set -euo pipefail

# Installs the standalone Android CLI and the SDK packages used by
# github-projects/kotlin-starter.
# Usage: ./install-android.sh [sdk-root]
# Default SDK root: $HOME/Android/Sdk

ANDROID_HOME="${1:-${ANDROID_HOME:-$HOME/Android/Sdk}}"
CLI_HOME="${ANDROID_CLI_HOME:-$HOME/.android}"
CLI_BIN="$CLI_HOME/bin/android"
CMDTOOLS_URL="${CMDTOOLS_URL:-https://dl.google.com/android/repository/commandlinetools-linux-15859902_latest.zip}"

need() {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 is required" >&2; exit 1; }
}

need curl
need unzip
need java

if [ ! -x "$CLI_BIN" ]; then
    echo "Installing Android CLI (standalone)..."
    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT

    curl -fsSL "$CMDTOOLS_URL" -o "$tmpdir/cmdtools.zip"
    unzip -q -o "$tmpdir/cmdtools.zip" -d "$tmpdir/cmdline-tools"

    # The command-line tools 'android' binary is only a bootstrap; on first run
    # it installs the standalone CLI into ~/.android/bin/android-cli.
    "$tmpdir/cmdline-tools/cmdline-tools/bin/android" -V >/dev/null
    [ -x "$CLI_HOME/bin/android-cli" ] || {
        echo "Android CLI bootstrap failed" >&2
        exit 1
    }
    ln -sf "$CLI_HOME/bin/android-cli" "$CLI_BIN"
    rm -rf "$tmpdir/cmdline-tools"
fi

export ANDROID_HOME
mkdir -p "$ANDROID_HOME"

echo "Installing SDK packages into $ANDROID_HOME..."
"$CLI_BIN" sdk install \
    platform-tools \
    "platforms;android-37.0" \
    "build-tools;37.0.0"

echo "Installed packages:"
"$CLI_BIN" sdk list

echo "Android SDK ready at $ANDROID_HOME"
echo "ANDROID_HOME is exported by ~/.zshenv / ~/.profile"

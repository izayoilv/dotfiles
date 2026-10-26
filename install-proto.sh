#!/usr/bin/env bash
set -euo pipefail

PROTO_VERSION="${PROTO_VERSION:-0.63.2}"
export PROTO_HOME="${PROTO_HOME:-$HOME/.proto}"
INSTALL_DIR="$PROTO_HOME/bin"
PYTHON_VERSION="${PYTHON_VERSION:-3.14}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

die() {
    echo "error: $*" >&2
    exit 1
}

for cmd in curl tar xz uname; do
    command -v "$cmd" >/dev/null 2>&1 || die "$cmd is required"
done

sha256_file() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | awk '{print $1}'
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | awk '{print $1}'
    else
        die "sha256sum or shasum is required"
    fi
}

detect_target() {
    local os arch libc
    os="$(uname -s)"
    arch="$(uname -m)"

    case "$os" in
        Linux)
            libc="gnu"
            if ldd --version 2>&1 | head -n 1 | grep -qi musl; then
                libc="musl"
            fi
            case "$arch" in
                x86_64) echo "x86_64-unknown-linux-$libc" ;;
                aarch64|arm64) echo "aarch64-unknown-linux-$libc" ;;
                *) die "unsupported architecture: $arch" ;;
            esac
            ;;
        Darwin)
            case "$arch" in
                x86_64) echo "x86_64-apple-darwin" ;;
                arm64) echo "aarch64-apple-darwin" ;;
                *) die "unsupported architecture: $arch" ;;
            esac
            ;;
        *)
            die "unsupported operating system: $os"
            ;;
    esac
}

installed_version() {
    if [ -x "$INSTALL_DIR/proto" ]; then
        "$INSTALL_DIR/proto" --version 2>/dev/null | awk '{print $2}' || true
    fi
}

install_proto() {
    local current target archive base_url expected actual extracted
    current="$(installed_version || true)"

    if [ "$current" = "$PROTO_VERSION" ]; then
        echo "proto ${PROTO_VERSION} already installed."
        return
    fi

    target="$(detect_target)"
    archive="proto_cli-${target}.tar.xz"
    base_url="https://github.com/moonrepo/proto/releases/download/v${PROTO_VERSION}"

    echo "Downloading proto ${PROTO_VERSION} for ${target}..."
    curl --proto '=https' --tlsv1.2 -fsSL "$base_url/$archive" -o "$TMP_DIR/$archive"
    curl --proto '=https' --tlsv1.2 -fsSL "$base_url/$archive.sha256" -o "$TMP_DIR/$archive.sha256"

    expected="$(awk '{print $1}' "$TMP_DIR/$archive.sha256")"
    actual="$(sha256_file "$TMP_DIR/$archive")"
    [ -n "$expected" ] && [ "$expected" = "$actual" ] || die "checksum mismatch for $archive"

    tar -xJf "$TMP_DIR/$archive" -C "$TMP_DIR"
    extracted="$TMP_DIR/proto_cli-${target}"
    [ -x "$extracted/proto" ] || die "proto binary missing from archive"

    install -m 755 "$extracted/proto" "$INSTALL_DIR/proto"
    install -m 755 "$extracted/proto-shim" "$INSTALL_DIR/proto-shim"
    echo "Installed proto ${PROTO_VERSION}."
}

ensure_rustup() {
    local target url expected actual
    if command -v rustup >/dev/null 2>&1; then
        echo "rustup already installed."
        return
    fi

    target="$(detect_target)"
    url="https://static.rust-lang.org/rustup/dist/${target}/rustup-init"

    echo "Installing rustup for ${target}..."
    curl --proto '=https' --tlsv1.2 -fsSL "$url" -o "$TMP_DIR/rustup-init"
    curl --proto '=https' --tlsv1.2 -fsSL "$url.sha256" -o "$TMP_DIR/rustup-init.sha256"

    expected="$(awk '{print $1}' "$TMP_DIR/rustup-init.sha256")"
    actual="$(sha256_file "$TMP_DIR/rustup-init")"
    [ -n "$expected" ] && [ "$expected" = "$actual" ] || die "checksum mismatch for rustup-init"

    chmod +x "$TMP_DIR/rustup-init"
    "$TMP_DIR/rustup-init" -y --default-toolchain none --no-modify-path
}

mkdir -p "$INSTALL_DIR"
install_proto

export PATH="$INSTALL_DIR:$PROTO_HOME/shims:$HOME/.cargo/bin:$PATH"

[ -f "$PROTO_HOME/.prototools" ] || die "global config missing at $PROTO_HOME/.prototools; run ./install.sh first"

ensure_rustup

echo "Installing global toolchain baseline..."
proto install --config-mode global -y

rustup default stable >/dev/null

uv python install "$PYTHON_VERSION"

echo "Global toolchain baseline is ready."

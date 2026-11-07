#!/usr/bin/env bash
set -euo pipefail

# Installs plenv (Perl version manager) + perl-build from GitHub.
# By default uses the system Perl (latest stable on Fedora Atomic) and installs
# Neovim::Ext for the nvim Perl provider. Pass --build to compile a separate
# Perl version (slow; ~10-20 min).
# Usage: ./install-plenv.sh [--build] [perl-version]

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PLENV_ROOT="${PLENV_ROOT:-$HOME/.plenv}"

BUILD=0
PERL_VERSION=""
if [ "${1:-}" = "--build" ]; then
    BUILD=1
    shift
fi
PERL_VERSION="${1:-}"

if [ ! -d "$PLENV_ROOT" ]; then
    echo "Cloning plenv..."
    git clone https://github.com/tokuhirom/plenv.git "$PLENV_ROOT"
fi
if [ ! -d "$PLENV_ROOT/plugins/perl-build" ]; then
    echo "Cloning perl-build..."
    git clone https://github.com/tokuhirom/Perl-Build.git "$PLENV_ROOT/plugins/perl-build"
fi

export PATH="$PLENV_ROOT/bin:$PLENV_ROOT/shims:$HOME/perl5/bin:$PATH"
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
eval "$("$PLENV_ROOT/bin/plenv" init -)"

if [ "$BUILD" = "1" ]; then
    if [ -z "$PERL_VERSION" ]; then
        PERL_VERSION="$(plenv install --list 2>/dev/null \
            | sed 's/^[[:space:]]*//' \
            | grep -E '^5\.[0-9]+\.[0-9]+$' \
            | awk -F. '{ if ($2 % 2 == 0) print }' \
            | sort -V | tail -1)"
        [ -n "$PERL_VERSION" ] || { echo "could not detect latest Perl" >&2; exit 1; }
        echo "Latest stable Perl: $PERL_VERSION"
    fi
    if ! plenv versions --bare 2>/dev/null | grep -qx "$PERL_VERSION"; then
        echo "Building Perl $PERL_VERSION (this may take a while)..."
        plenv install "$PERL_VERSION"
    fi
    plenv global "$PERL_VERSION"
else
    plenv global system 2>/dev/null || true
    echo "Using system Perl ($(perl -v | sed -n '2p' | tr -d '\n'))"
fi
plenv rehash

echo "Installing cpanm + Neovim::Ext..."
if ! command -v cpanm >/dev/null 2>&1; then
    curl -L https://cpanmin.us | perl - App::cpanminus
fi
cpanm --notest Neovim::Ext

echo "plenv ready: $(perl -v | sed -n '2p' | tr -d '\n')"
echo "Neovim::Ext: $(perl -e 'use Neovim::Ext; print "ok\n"')"
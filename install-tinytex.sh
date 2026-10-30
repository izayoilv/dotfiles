#!/usr/bin/env bash
set -euo pipefail

TINYTEX_VERSION="${TINYTEX_VERSION:-2026.10}"
TINYTEX_HOME="${TINYTEX_HOME:-$HOME/.TinyTeX}"
TINYTEX_BUNDLE="TinyTeX-1-linux-x86_64-v${TINYTEX_VERSION}.tar.xz"
TINYTEX_SHA256="4d519d6236ee6798e3ec0d8e2093d1fda01aeb267aa22c2a5586d76bcfce6566"
TINYTEX_URL="https://github.com/rstudio/tinytex-releases/releases/download/v${TINYTEX_VERSION}/${TINYTEX_BUNDLE}"
TINYTEX_BIN="$TINYTEX_HOME/bin/x86_64-linux"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

die() {
    echo "error: $*" >&2
    exit 1
}

for cmd in curl tar xz uname; do
    command -v "$cmd" >/dev/null 2>&1 || die "$cmd is required"
done

[ "$(uname -s)" = "Linux" ] && [ "$(uname -m)" = "x86_64" ] || die "supported platform: Linux x86_64"

if ! ldconfig -p 2>/dev/null | grep -q 'libcrypt.so.1' \
    && [ ! -e /lib64/libcrypt.so.1 ] \
    && [ ! -e /usr/lib64/libcrypt.so.1 ]; then
    die "TinyTeX's biber requires libcrypt.so.1; run: sudo dnf install libxcrypt-compat"
fi

sha256_file() {
    if command -v sha256sum >/dev/null 2>&1; then
        sha256sum "$1" | awk '{print $1}'
    elif command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | awk '{print $1}'
    else
        die "sha256sum or shasum is required"
    fi
}

if [ ! -x "$TINYTEX_BIN/tlmgr" ]; then
    echo "Downloading TinyTeX ${TINYTEX_VERSION}..."
    curl --proto '=https' --tlsv1.2 -fsSL "$TINYTEX_URL" -o "$TMP_DIR/$TINYTEX_BUNDLE"

    actual="$(sha256_file "$TMP_DIR/$TINYTEX_BUNDLE")"
    [ "$actual" = "$TINYTEX_SHA256" ] || die "checksum mismatch for $TINYTEX_BUNDLE"

    mkdir -p "$TMP_DIR/extract"
    tar -xJf "$TMP_DIR/$TINYTEX_BUNDLE" -C "$TMP_DIR/extract"
    rm -rf "$TINYTEX_HOME"
    mv "$TMP_DIR/extract/.TinyTeX" "$TINYTEX_HOME"
    echo "Installed TinyTeX ${TINYTEX_VERSION}."
else
    echo "TinyTeX already installed at $TINYTEX_HOME."
fi

echo "Updating tlmgr..."
"$TINYTEX_BIN/tlmgr" update --self

echo "Installing LaTeX packages..."
if ! "$TINYTEX_BIN/tlmgr" install \
    collection-latexrecommended \
    collection-luatex \
    collection-fontsrecommended \
    babel \
    babel-english \
    biblatex \
    biblatex-apa \
    biber \
    booktabs \
    caption \
    csquotes \
    enumitem \
    environ \
    fontspec \
    geometry \
    graphics \
    hyperref \
    latexmk \
    lastpage \
    ltablex \
    makecell \
    microtype \
    needspace \
    pdfcol \
    setspace \
    tcolorbox \
    tikzfill \
    titlesec \
    trimspaces \
    unicode-math \
    xltabular; then
    echo "tlmgr post-install hook failed; rebuilding the LuaLaTeX format..."
fi

if ! "$TINYTEX_BIN/fmtutil-sys" --byfmt lualatex >"$TMP_DIR/fmtutil.log" 2>&1; then
    cat "$TMP_DIR/fmtutil.log" >&2
    die "failed to build the LuaLaTeX format"
fi

for pkg in apa.bbx csquotes.sty ltablex.sty titlesec.sty unicode-math.sty xltabular.sty enumitem.sty; do
    [ -n "$("$TINYTEX_BIN/kpsewhich" "$pkg")" ] || die "missing TeX package: $pkg"
done

"$TINYTEX_BIN/tlmgr" --version | head -n 2
"$TINYTEX_BIN/lualatex" --version | head -n 1
"$TINYTEX_BIN/latexmk" -v | head -n 1
"$TINYTEX_BIN/biber" --version | head -n 1

echo "TinyTeX is ready at $TINYTEX_HOME."

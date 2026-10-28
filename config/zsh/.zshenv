typeset -U path
path=(
    "$HOME/.proto/shims"
    "$HOME/.proto/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.local/share/npm/bin"
    "$HOME/.local/share/pnpm/bin"
    "$HOME/.TinyTeX/bin/x86_64-linux"
    "$HOME/.TinyTeX/bin/aarch64-linux"
    $path
)
export PATH

export PROTO_HOME="$HOME/.proto"
export NPM_CONFIG_PREFIX="$HOME/.local/share/npm"
export PNPM_HOME="$HOME/.local/share/pnpm"

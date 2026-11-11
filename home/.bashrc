if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -z "${DOTFILES_PROFILE_LOADED:-}" ] && [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path "$HOME/bin"
add_to_path "$HOME/.composer/vendor/bin"
add_to_path "$HOME/.android/bin"
add_to_path "$ANDROID_HOME/platform-tools"
add_to_path "/home/linuxbrew/.linuxbrew/bin"
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
add_to_path "$HOME/.plenv/bin"
add_to_path "$HOME/perl5/bin"
add_to_path "$HOME/.dotnet"
add_to_path "$HOME/.dotnet/tools"
if [ -x "$HOME/.plenv/bin/plenv" ]; then
    eval "$("$HOME/.plenv/bin/plenv" init -)"
fi
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
export DOTNET_ROOT="$HOME/.dotnet"

if [ -d "$HOME/.bashrc.d" ]; then
    for rc in "$HOME"/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
    unset rc
fi

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

export BERG_BASE_URL="codeberg.org"
export PLAYWRIGHT_BROWSERS_PATH="$HOME/.cache/ms-playwright"
export KUBECONFIG="$HOME/.kube/config"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"

if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

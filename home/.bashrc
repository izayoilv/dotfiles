if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -z "${DOTFILES_PROFILE_LOADED:-}" ] && [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"

add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path "$HOME/bin"
add_to_path "$HOME/.composer/vendor/bin"
add_to_path "$HOME/.dotnet/tools"
add_to_path "$ANDROID_HOME/cmdline-tools/latest/bin"
add_to_path "$ANDROID_HOME/platform-tools"

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

if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi
